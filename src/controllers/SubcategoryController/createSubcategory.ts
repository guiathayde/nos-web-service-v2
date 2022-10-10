import { Request, Response } from 'express';
import { PrismaClient } from '@prisma/client';

import AppError from '../../errors/AppError';

interface NewSubcategoryProps {
  name: string;
  priority: number;
  categoryId: string;
}

export async function createSubcategory(request: Request, response: Response) {
  const { name, priority, categoryId } = request.body as NewSubcategoryProps;

  const prisma = new PrismaClient();

  const subcategory = await prisma.subcategory.create({
    data: {
      name,
      priority,
      category: {
        connect: {
          id: categoryId,
        },
      },
    },
  });

  return response.status(201).json(subcategory);
}
