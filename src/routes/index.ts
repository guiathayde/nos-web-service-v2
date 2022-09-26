import { Router } from 'express';

import userRouter from './user.routes';
import institutionRouter from './institution.routes';

const routes = Router();

routes.use('/user', userRouter);
routes.use('/institution', institutionRouter);

export default routes;
