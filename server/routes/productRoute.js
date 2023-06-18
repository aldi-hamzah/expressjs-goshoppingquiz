import { Router } from 'express';
import productController from '../controllers/ProductController';

const router = Router();

router.get('/all', productController.findAll);

export default router;
