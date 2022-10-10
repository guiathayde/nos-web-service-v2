import { Router } from 'express';
import multer from 'multer';
import uploadConfig from '../config/uploadFile';

import { ensureAuthenticated } from '../middleware/ensureAuthenticated';
import { ensureAdmin } from '../middleware/ensureAdmin';

import { createPublic } from '../controllers/PublicController/createPublic';

const publicRouter = Router();

const upload = multer(uploadConfig.multer);

publicRouter.post(
  '/create',
  ensureAuthenticated,
  ensureAdmin,
  upload.single('image'),
  createPublic,
);

export default publicRouter;
