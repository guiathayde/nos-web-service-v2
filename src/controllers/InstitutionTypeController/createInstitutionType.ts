import { Request, Response } from 'express';
import { PrismaClient } from '@prisma/client';

import AppError from '../../errors/AppError';

import { storageProvider } from '../../providers/StorageProvider';

interface RequestBody {
  name: string;
}

export async function createInstitutionType(
  request: Request,
  response: Response,
) {
  const { name } = JSON.parse(request.body.data) as RequestBody;

  if (!name || !request.file) {
    throw new AppError('Missing required fields.', 400);
  }

  const { fileId, fileUrl } = await storageProvider.saveFile(
    request.file.filename,
  );

  const prisma = new PrismaClient();

  const institutionType = await prisma.institutionType.create({
    data: {
      name,
      imageId: fileId,
      imageUrl: fileUrl,
    },
  });

  return response.status(201).json(institutionType);
}
