const findAll = async (req, res) => {
  const category = await req.context.models.product.findAll({
    where: { category: 'c3bdf859-bea0-4d9e-a759-6f2f081ccbf4' },
  });
  // category.forEach(item => {
  //   console.log(item.dataValues);
  // })
  return res.send(category);
};

const getOrderUser = async () => {
  const category = await req.context.models.product.findAll({
    where: { category: 'c3bdf859-bea0-4d9e-a759-6f2f081ccbf4' },
  });
  // category.forEach(item => {
  //   console.log(item.dataValues);
  // })
  return res.send(category);
};

export default {
  findAll,
};
