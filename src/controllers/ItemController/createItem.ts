import { Request, Response } from 'express';
import { PrismaClient } from '@prisma/client';

import { storageProvider } from '../../providers/StorageProvider';

import AppError from '../../errors/AppError';

interface NewItemProps {
  name: string;
  priority: number;
  subcategoryId: string;
}

export async function createItem(request: Request, response: Response) {
  const { name, priority, subcategoryId } = JSON.parse(
    request.body.data,
  ) as NewItemProps;

  if (!name || !priority || !subcategoryId || !request.file) {
    throw new AppError('Some data no provided', 400);
  }

  const imageFilename = request.file.filename;

  const { fileId, fileUrl } = await storageProvider.saveFile(imageFilename);

  const prisma = new PrismaClient();

  const item = await prisma.item.create({
    data: {
      name,
      priority,
      imageId: fileId,
      imageUrl: fileUrl,
      subcategory: {
        connect: {
          id: subcategoryId,
        },
      },
    },
  });

  return response.status(201).json(item);
}
