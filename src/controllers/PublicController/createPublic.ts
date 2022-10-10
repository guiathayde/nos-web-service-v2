import { Request, Response } from 'express';
import { PrismaClient } from '@prisma/client';

import AppError from '../../errors/AppError';

import { storageProvider } from '../../providers/StorageProvider';

interface RequestBody {
  name: string;
}

export async function createPublic(request: Request, response: Response) {
  const { name } = JSON.parse(request.body.data) as RequestBody;

  if (!name || !request.file) {
    throw new AppError('Some data no provided.', 400);
  }

  const { fileId, fileUrl } = await storageProvider.saveFile(
    request.file.filename,
  );

  const prisma = new PrismaClient();

  const publicCreated = await prisma.public.create({
    data: {
      name,
      imageId: fileId,
      imageUrl: fileUrl,
    },
  });

  return response.status(201).json(publicCreated);
}
