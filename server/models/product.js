import _sequelize from 'sequelize';
const { Model, Sequelize } = _sequelize;

export default class product extends Model {
  static init(sequelize, DataTypes) {
  return super.init({
    prodid: {
      type: DataTypes.UUID,
      allowNull: false,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true
    },
    name: {
      type: DataTypes.STRING(200),
      allowNull: true
    },
    category: {
      type: DataTypes.UUID,
      allowNull: true,
      references: {
        model: 'category',
        key: 'cateid'
      }
    },
    stock: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    price: {
      type: DataTypes.DECIMAL,
      allowNull: true
    }
  }, {
    sequelize,
    tableName: 'product',
    schema: 'public',
    timestamps: false,
    indexes: [
      {
        name: "product_pkey",
        unique: true,
        fields: [
          { name: "prodid" },
        ]
      },
    ]
  });
  }
}
