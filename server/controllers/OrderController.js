import { sequelize } from '../models/init-models';
import cartController from './CartController';
import productController from './ProductController';
import models from '../models/init-models';

const createOrder = async (req, res) => {
  const data = req.body;

  if (data.username == '') {
    return res.send(`Please input username.`);
  }

  const user = await cartController.getUserData(data.username);

  if (user == null) {
    return res.send(`Username not found.`);
  }

  const cartUser = await getCartUser(user.dataValues.userid);

  if (cartUser == null) {
    return res.send(`You dont have a cart.`);
  }

  try {
    let order = await req.context.models.orders.create({
      user: user.dataValues.userid,
      totalprice: 0,
      status: 'OPEN',
    });

    let totalprice = 0;

    for (const item of cartUser) {
      await req.context.models.orderlineitem.create({
        product: item.dataValues.product,
        qty: item.dataValues.qty,
        subtotal: item.dataValues.subtotal,
        order: order.dataValues.orderid,
      });

      totalprice += parseInt(item.dataValues.subtotal);

      req.context.models.itemproduct.destroy({
        where: { cartid: item.dataValues.cartid },
      });
      console.log(totalprice);
    }

    order = await req.context.models.orders.update(
      {
        totalprice: totalprice,
      },
      { returning: true, where: { orderid: order.dataValues.orderid } }
    );

    console.log(order);

    return res.send(order);
  } catch (error) {
    return res.send(error);
  }
};

const closeOrder = async (req, res) => {
  const data = req.body;

  if (data.orderno == '') {
    return res.send(`Please input orderno.`);
  }

  const orderno = await req.context.models.orders.findOne({
    where: { orderno: data.orderno },
  });

  if (orderno == null) {
    return res.send('Order not found.');
  }

  if (orderno.dataValues.status === 'CLOSED') {
    return res.send('Order already closed.');
  }

  try {
    await req.context.models.orders.update(
      {
        status: 'CLOSED',
      },
      { returning: true, where: { orderno: data.orderno } }
    );

    const getOrder = await req.context.models.orders.findAll({
      where: { orderno: data.orderno },
      include: [
        {
          model: req.context.models.orderlineitem,
          as: 'orderlineitems',
        },
      ],
    });

    return res.send(getOrder);
  } catch (error) {
    return res.send(error);
  }
};

const cancelOrder = async (req, res) => {
  const data = req.body;

  if (data.orderno == '') {
    return res.send(`Please input orderno.`);
  }

  const order = await req.context.models.orders.findOne({
    where: { orderno: data.orderno },
  });

  if (order == null) {
    return res.send('Order not found.');
  }

  if (order.dataValues.status === 'CANCEL') {
    return res.send('Order already cancelled.');
  }

  const orderlineitem = await getOrderUser(order.dataValues.orderid);

  try {
    await req.context.models.orders.update(
      {
        status: 'CANCEL',
      },
      { returning: true, where: { orderno: data.orderno } }
    );

    for (const order of orderlineitem) {
      let product = await getProduct(order.dataValues.product);
      console.log(product.dataValues);
      await req.context.models.product.update(
        {
          stock: product.dataValues.stock + order.dataValues.qty,
        },
        { where: { prodid: order.dataValues.product } }
      );
    }

    const getOrder = await req.context.models.orders.findAll({
      where: { orderno: data.orderno },
      include: [
        {
          model: req.context.models.orderlineitem,
          as: 'orderlineitems',
        },
      ],
    });

    return res.send(getOrder);
  } catch (error) {
    return res.send(error);
  }
};

const getCartUser = async (uuid) => {
  try {
    const cart = models.itemproduct.findAll({
      where: { user: uuid },
    });
    return cart;
  } catch (error) {
    return error;
  }
};

const getOrderUser = async (uuid) => {
  try {
    const order = await models.orderlineitem.findAll({
      where: { order: uuid },
    });
    return order;
  } catch (error) {
    return error;
  }
};

const getProduct = async (uuid) => {
  try {
    const product = await models.product.findOne({
      where: { prodid: uuid },
    });
    return product;
  } catch (error) {
    return error;
  }
};

export default {
  createOrder,
  closeOrder,
  cancelOrder,
};
