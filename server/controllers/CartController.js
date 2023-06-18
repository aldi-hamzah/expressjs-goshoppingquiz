import models from '../models/init-models';
import { sequelize } from '../models/init-models';

const addToCart = async (req, res) => {
  const data = req.body;
  if (data.product == '') {
    return res.send(`Please input product name.`);
  } else if (data.quantity == '') {
    return res.send(`Please input quantity.`);
  } else if (data.username == '') {
    return res.send(`Please input your username`);
  }

  const user = await getUserData(data.username);

  if (user == null) {
    return res.send(`Username not found.`);
  }

  const product = await getProductData(data.product);

  if (product == null) {
    return res.send(`Product not found.`);
  }

  if (product.dataValues.stock === 0) {
    return res.send(`Stok sudah habis`);
  } else if (data.quantity > product.dataValues.stock) {
    return res.send(`Stok tidak tersedia.`);
  }

  const orderData = await findOneCart(
    user.dataValues.userid,
    product.dataValues.prodid
  );

  try {
    let order;

    const t = await sequelize.transaction();

    if (orderData == null) {
      order = await req.context.models.itemproduct.create(
        {
          product: product.dataValues.prodid,
          qty: data.quantity,
          subtotal: data.quantity * parseInt(product.dataValues.price),
          user: user.dataValues.userid,
        },
        { transaction: t }
      );
    } else {
      order = await req.context.models.itemproduct.update(
        {
          qty: parseInt(orderData.dataValues.qty) + parseInt(data.quantity),
          subtotal:
            parseInt(orderData.dataValues.subtotal) +
            data.quantity * parseInt(product.dataValues.price),
        },
        { returning: true, where: { cartid: orderData.dataValues.cartid } },
        { transaction: t }
      );
    }

    await req.context.models.product.update(
      {
        stock: product.dataValues.stock - data.quantity,
      },
      { where: { prodid: product.dataValues.prodid } },
      { transaction: t }
    );

    await t.commit();
    return res.send(order);
  } catch (error) {
    await t.rollback();
    return res.send(error);
  }
};

const findOneCart = async (userUser, userProduct) => {
  const order = await models.itemproduct.findOne({
    where: { user: userUser, product: userProduct },
  });
  return order;
};

const getUserData = async (username) => {
  const user = await models.users.findOne({
    where: { username: username },
  });
  return user;
};

const getProductData = async (productName) => {
  const product = await models.product.findOne({
    where: { name: productName },
  });
  return product;
};

export default {
  addToCart,
  getUserData,
  getProductData,
};
