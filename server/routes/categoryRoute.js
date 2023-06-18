import { Router } from 'express';
import categoryController from '../controllers/CategoryController';

const router = Router();

router.get('/all', categoryController.findAll);

export default router;
