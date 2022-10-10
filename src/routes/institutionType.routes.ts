import { Router } from 'express';
import multer from 'multer';
import uploadConfig from '../config/uploadFile';

import { ensureAuthenticated } from '../middleware/ensureAuthenticated';
import { ensureAdmin } from '../middleware/ensureAdmin';

import { createInstitutionType } from '../controllers/InstitutionTypeController/createInstitutionType';

const institutionTypeRouter = Router();

const upload = multer(uploadConfig.multer);

institutionTypeRouter.post(
  '/create',
  ensureAuthenticated,
  ensureAdmin,
  upload.single('image'),
  createInstitutionType,
);

export default institutionTypeRouter;
