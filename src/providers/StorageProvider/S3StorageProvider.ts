// Caso um dia usarmos uma CDN para armazenar as imagens, o código abaixo será usado.
// A dependencia aws-sdk atualmente só está em ambiente de desenvolvimento.

import fs from 'fs';
import path from 'path';
import mime from 'mime';
import aws from 'aws-sdk';
import uploadConfig from '../../config/uploadFile';

interface SaveFileResponse {
  fileId: string;
  fileUrl: string;
}

function getClient() {
  const client = new aws.S3({
    region: 'us-east-1',
  });

  return client;
}

export async function saveFile(file: string): Promise<SaveFileResponse> {
  const originalPath = path.resolve(uploadConfig.uploadsFolder, file);

  const ContentType = mime.getType(originalPath);

  if (!ContentType) {
    throw new Error('File not found');
  }

  const fileContent = await fs.promises.readFile(originalPath);

  const client = await getClient();

  await client
    .putObject({
      Bucket: uploadConfig.config.aws.bucket,
      Key: file,
      ACL: 'public-read',
      Body: fileContent,
      ContentType,
      ContentDisposition: `inline; filename=${file}`,
    })
    .promise();

  await fs.promises.unlink(originalPath);

  return {
    fileId: file,
    fileUrl: `https://${uploadConfig.config.aws.bucket}.s3.amazonaws.com/${file}`,
  };
}

export async function deleteFile(file: string): Promise<void> {
  const client = await getClient();

  await client
    .deleteObject({
      Bucket: uploadConfig.config.aws.bucket,
      Key: file,
    })
    .promise();
}
