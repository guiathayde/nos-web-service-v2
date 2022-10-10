import * as diskStorageProvider from './DiskStorageProvider';
import * as s3StorageProvider from './S3StorageProvider';

export const storageProvider =
  process.env.STORAGE_DRIVER === 'disk'
    ? diskStorageProvider
    : s3StorageProvider;
