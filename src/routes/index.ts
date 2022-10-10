import { Router } from 'express';

import userRouter from './user.routes';
import institutionRouter from './institution.routes';
import categoryRouter from './category.routes';
import subcategoryRouter from './subcategory.routes';
import publicRouter from './public.routes';
import institutionTypeRouter from './institutionType.routes';
import itemRouter from './item.routes';

const routes = Router();

routes.use('/user', userRouter);
routes.use('/institution', institutionRouter);
routes.use('/category', categoryRouter);
routes.use('/subcategory', subcategoryRouter);
routes.use('/public', publicRouter);
routes.use('/institutionType', institutionTypeRouter);
routes.use('/item', itemRouter);

export default routes;
