import 'dotenv/config';
import express from 'express';
import cors from 'cors';
import compression from 'compression';
import helmet from 'helmet';
import routes from './routes/indexRoute';
import cookieParser from 'cookie-parser';
import models, { sequelize } from './models/init-models';

const port = process.env.PORT || 3002;
const app = express();

console.log('ABCC');

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser());
app.use(helmet());
app.use(cors());
app.use(compression());

app.use(async (req, res, next) => {
  req.context = { models };
  next();
});

app.use(`/category`, routes.categoryRoute);
app.use(`/product`, routes.productRoute);
app.use(`/cart`, routes.cartRoute);
app.use(`/order`, routes.orderRoute);

const dropDatabaseSync = false;

sequelize.sync({ force: dropDatabaseSync }).then(async () => {
  if (dropDatabaseSync) {
    console.log(`Database do not drop!`);
  }
  app.listen(port, () => {
    console.log(`Server is listening on http://localhost:${port}`);
  });
});

export default app;
