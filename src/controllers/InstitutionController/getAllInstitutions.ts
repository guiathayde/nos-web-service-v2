import { Request, Response } from 'express';
import { PrismaClient } from '@prisma/client';

export async function getAllInstitutions(request: Request, response: Response) {
  const prisma = new PrismaClient();

  const institutions = await prisma.institution.findMany({
    include: {
      publicType: true,
      institutionType: true,
      categories: true,
      items: true,
      institutionVerification: true,
    },
  });

  return response.status(200).json(institutions);
}
