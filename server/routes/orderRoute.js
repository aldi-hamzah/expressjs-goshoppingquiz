import { Router } from 'express';
import orderController from '../controllers/OrderController';

const router = Router();

router.post('/add', orderController.createOrder);
router.post('/close', orderController.closeOrder);
router.post('/cancel', orderController.cancelOrder);

export default router;
