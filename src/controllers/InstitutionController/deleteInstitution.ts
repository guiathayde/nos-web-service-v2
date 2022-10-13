import { Request, Response } from 'express';
import { PrismaClient } from '@prisma/client';

import { storageProvider } from '../../providers/StorageProvider';

export async function deleteInstitution(request: Request, response: Response) {
  const { id } = request.params;

  const prisma = new PrismaClient();

  const institution = await prisma.institution.delete({
    where: {
      id,
    },
    include: {
      institutionVerification: true,
    },
  });

  await storageProvider.deleteFile(institution.profileImageId);
  institution.galleryImagesIds.forEach(async imageId => {
    await storageProvider.deleteFile(imageId);
  });

  return response.status(200).json({
    institution,
  });
}
