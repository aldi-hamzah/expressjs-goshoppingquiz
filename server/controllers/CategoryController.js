const findAll = async (req, res) => {
  const category = await req.context.models.category.findAll();
  return res.send(category);
};

export default {
  findAll,
};
