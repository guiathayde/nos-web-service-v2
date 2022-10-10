import fs from 'fs';
import path from 'path';
import uploadConfig from '../../config/uploadFile';

interface SaveFileResponse {
  fileId: string;
  fileUrl: string;
}

export async function saveFile(file: string): Promise<SaveFileResponse> {
  await fs.promises.rename(
    path.resolve(uploadConfig.tmpFolder, file),
    path.resolve(uploadConfig.uploadsFolder, file),
  );

  return {
    fileId: file,
    fileUrl: `${process.env.APP_API_URL}/files/${file}`,
  };
}

export async function deleteFile(file: string): Promise<void> {
  const filePath = path.resolve(uploadConfig.uploadsFolder, file);

  try {
    await fs.promises.stat(filePath);
  } catch {
    return;
  }

  await fs.promises.unlink(filePath);
}
