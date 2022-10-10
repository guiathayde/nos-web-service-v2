import { Request, Response } from 'express';
import { PrismaClient } from '@prisma/client';

import { storageProvider } from '../../providers/StorageProvider';

import AppError from '../../errors/AppError';

interface NewCategoryProps {
  name: string;
  priority: number;
  backgroundColor: string;
}

export async function createCategory(request: Request, response: Response) {
  const { name, priority, backgroundColor } = JSON.parse(
    request.body.data,
  ) as NewCategoryProps;

  if (!name || !priority || !backgroundColor || !request.file)
    throw new AppError('Some data no provided.', 400);

  const imageFilename = request.file.filename;

  const { fileId, fileUrl } = await storageProvider.saveFile(imageFilename);

  const prisma = new PrismaClient();

  const category = await prisma.category.create({
    data: {
      name,
      priority,
      backgroundColor,
      imageId: fileId,
      imageUrl: fileUrl,
    },
  });

  return response.status(201).json(category);
}
