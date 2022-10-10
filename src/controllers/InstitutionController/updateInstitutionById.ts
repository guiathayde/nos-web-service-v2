import { Request, Response } from 'express';
import { PrismaClient } from '@prisma/client';

import AppError from '../../errors/AppError';

import { storageProvider } from '../../providers/StorageProvider';

interface RequestBody {
  deliverInfo?: string;
  description?: string;
  generalAddress?: string;
  lat?: string;
  lon?: string;
  institutionName?: string;
  institutionPhone?: number;
  quantity?: string;
  responsiblePersonEmail?: string;
  responsiblePersonName?: string;
  responsiblePersonPhone?: string;
  site?: string;
  workingDays?: string;
  bankInfo?: string;
  customNeed?: string;
  customService?: string;
  crowdfunding?: string;
  corporateName?: string;
  cnpj?: string;

  publicTypeId?: string;
  institutionTypeId?: string;

  itemsIdsToInclude?: string[];
  itemsIdsToRemove?: string[];

  categoriesIdsToInclude?: string[];
  categoriesIdsToRemove?: string[];
}

interface UpdateInstitution
  extends Omit<
    RequestBody,
    | 'itemsIdsToInclude'
    | 'itemsIdsToRemove'
    | 'categoriesIdsToInclude'
    | 'categoriesIdsToRemove'
  > {
  profileImageId?: string;
  profileImageUrl?: string;
  galleryImagesIds?: string[];
  galleryImagesUrls?: string[];
}

interface Images {
  profileImage: Express.Multer.File[] | undefined;
  galleryImages: Express.Multer.File[] | undefined;
}

export async function updateInstitutionById(
  request: Request,
  response: Response,
) {
  const { id } = request.params;
  const {
    itemsIdsToInclude,
    itemsIdsToRemove,
    categoriesIdsToInclude,
    categoriesIdsToRemove,
    ...institutionUpdate
  } = JSON.parse(request.body.data) as RequestBody;

  const prisma = new PrismaClient();

  const oldInstitution = await prisma.institution.findUnique({ where: { id } });

  if (!oldInstitution) {
    throw new AppError('Institution not found', 400);
  }

  const images = request.files as unknown as Images;

  let profileImageId: string | undefined = undefined;
  let profileImageUrl: string | undefined = undefined;
  let galleryImagesIds: string[] | undefined = undefined;
  let galleryImagesUrls: string[] | undefined = undefined;
  if (images) {
    if (images.profileImage) {
      await storageProvider.deleteFile(oldInstitution.profileImageId);
      const { fileId, fileUrl } = await storageProvider.saveFile(
        images.profileImage[0].filename,
      );
      profileImageId = fileId;
      profileImageUrl = fileUrl;
    }

    if (images.galleryImages) {
      oldInstitution.galleryImagesIds.forEach(
        async imageId => await storageProvider.deleteFile(imageId),
      );

      const imagesData = await Promise.all(
        images.galleryImages.map(image =>
          storageProvider.saveFile(image.filename),
        ),
      );
      imagesData.forEach(({ fileId, fileUrl }) => {
        galleryImagesIds = [...(galleryImagesIds || []), fileId];
        galleryImagesUrls = [...(galleryImagesUrls || []), fileUrl];
      });
    }
  }

  const institutionUpdated = await prisma.institution.update({
    where: {
      id,
    },
    data: {
      ...institutionUpdate,
      profileImageId,
      profileImageUrl,
      galleryImagesIds,
      galleryImagesUrls,
      items: {
        connect: itemsIdsToInclude?.map(itemId => ({ id: itemId })),
        disconnect: itemsIdsToRemove?.map(itemId => ({ id: itemId })),
      },
      categories: {
        connect: categoriesIdsToInclude?.map(categoryId => ({
          id: categoryId,
        })),
        disconnect: categoriesIdsToRemove?.map(categoryId => ({
          id: categoryId,
        })),
      },
    },
  });

  return response.status(200).json(institutionUpdated);
}
