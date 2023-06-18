import { Router } from 'express';
import cartController from '../controllers/CartController';

const router = Router();

router.post('/add', cartController.addToCart);

export default router;
