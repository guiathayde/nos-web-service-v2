import { Request, Response } from 'express';
import { PrismaClient } from '@prisma/client';

export async function deleteInstitution(request: Request, response: Response) {
  const { id } = request.params;

  const prisma = new PrismaClient();

  const institutionVerification = await prisma.institutionVerification.delete({
    where: { institutionId: id },
  });

  const institution = await prisma.institution.delete({
    where: {
      id,
    },
  });

  return response.status(200).json({
    institution,
    institutionVerification,
  });
}
