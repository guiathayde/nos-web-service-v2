import { Request, Response } from 'express';
import { PrismaClient } from '@prisma/client';

import { storageProvider } from '../../providers/StorageProvider';

import AppError from '../../errors/AppError';

interface RequestBody {
  deliverInfo: string;
  description: string;
  generalAddress: string;
  lat: string;
  lon: string;
  institutionName: string;
  institutionPhone: number;
  quantity: string;
  responsiblePersonEmail: string;
  responsiblePersonName: string;
  responsiblePersonPhone: string;
  site: string;
  workingDays: string;
  bankInfo: string;
  customNeed: string;
  customService: string;
  crowdfunding: string;
  corporateName: string;
  cnpj: string;

  publicTypeId: string;
  institutionTypeId: string;

  itemsIds: string[];
  categoriesIds: string[];
}

interface NewInstitutionProps
  extends Omit<
    RequestBody,
    'publicTypeId' | 'institutionTypeId' | 'itemsIds' | 'categoriesIds'
  > {
  profileImageId: string;
  profileImageUrl: string;
  galleryImagesIds: string[];
  galleryImagesUrls: string[];
}

interface Images {
  profileImage: Express.Multer.File[] | undefined;
  galleryImages: Express.Multer.File[] | undefined;
}

function cleanURL(url: string) {
  const sites = url || '';
  const sitesArr = sites.toString().split(' ');

  let web = sitesArr.find((item, index) => sitesArr[index - 1] === 'Site:');
  let facebook = sitesArr.find(
    (item, index) => sitesArr[index - 1] === 'Facebook:',
  );
  let instagram = sitesArr.find(
    (item, index) => sitesArr[index - 1] === 'Instagram:',
  );

  web = web || '';
  facebook = facebook || '';
  instagram = instagram || '';

  const webKey = '//';
  const fbKey = 'www.facebook.com';
  const igKey = 'www.instagram.com';

  web = web.split(webKey)[1] || web;
  facebook = facebook.split(fbKey)[1] || facebook;
  instagram = instagram.split(igKey)[1] || instagram;

  return `Site: ${web} , Facebook: ${facebook} , Instagram: ${instagram}`;
}

export async function createInstitution(request: Request, response: Response) {
  try {
    const {
      publicTypeId,
      institutionTypeId,
      itemsIds,
      categoriesIds,
      ...newInstitutionData
    } = JSON.parse(request.body.data) as RequestBody;
    const newInstitution: NewInstitutionProps = {
      ...newInstitutionData,
      profileImageId: '',
      profileImageUrl: '',
      galleryImagesIds: [],
      galleryImagesUrls: [],
    };

    if (!request.files) {
      throw new AppError('No images provided.', 400);
    }

    const images = request.files as unknown as Images | undefined;

    newInstitution.site = cleanURL(newInstitution.site);

    if (images) {
      if (images.profileImage) {
        const { fileId, fileUrl } = await storageProvider.saveFile(
          images.profileImage[0].filename,
        );
        newInstitution.profileImageId = fileId;
        newInstitution.profileImageUrl = fileUrl;
      }

      if (images.galleryImages) {
        const galleryImagesFilenames = images.galleryImages.map(
          image => image.filename,
        );
        const imagesData = await Promise.all(
          galleryImagesFilenames.map(image => storageProvider.saveFile(image)),
        );

        imagesData.forEach(imageData => {
          newInstitution.galleryImagesIds.push(imageData.fileId);
          newInstitution.galleryImagesUrls.push(imageData.fileUrl);
        });
      }
    }

    try {
      const prisma = new PrismaClient();

      const institutionResponse = await prisma.institution.create({
        data: {
          ...newInstitution,
          publicType: {
            connect: { id: publicTypeId },
          },
          institutionType: {
            connect: { id: institutionTypeId },
          },
          items: {
            connect: itemsIds.map(id => ({ id })),
          },
          categories: {
            connect: categoriesIds.map(id => ({ id })),
          },
          institutionVerification: {
            create: {
              stageOne: {
                create: {},
              },
              stageTwo: {
                create: {},
              },
              stageThree: {
                create: {},
              },
            },
          },
        },
        include: {
          institutionType: true,
          publicType: true,
          categories: true,
          items: true,
          institutionVerification: true,
        },
      });

      return response.status(201).json(institutionResponse);
    } catch (error) {
      console.error({ error });
      throw new AppError(`Error on create institution. ${error}`);
    }
  } catch (error) {
    console.error({ error });
    throw new AppError(`Error on create institution. ${error}`);
  }
}
