import { Request, Response } from 'express';

export async function createInstitution(request: Request, response: Response) {
  return response.json({
    message: 'Instituição criada com sucesso.',
  });
}
