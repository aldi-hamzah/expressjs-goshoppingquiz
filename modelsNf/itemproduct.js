import _sequelize from 'sequelize';
const { Model, Sequelize } = _sequelize;

export default class itemproduct extends Model {
  static init(sequelize, DataTypes) {
  return super.init({
    cartid: {
      type: DataTypes.UUID,
      allowNull: false,
      defaultValue: DataTypes.UUIDV4,
      primaryKey: true
    },
    product: {
      type: DataTypes.UUID,
      allowNull: true,
      references: {
        model: 'product',
        key: 'prodid'
      }
    },
    qty: {
      type: DataTypes.INTEGER,
      allowNull: true
    },
    subtotal: {
      type: DataTypes.DECIMAL,
      allowNull: true
    },
    user: {
      type: DataTypes.UUID,
      allowNull: true,
      references: {
        model: 'users',
        key: 'userid'
      }
    }
  }, {
    sequelize,
    tableName: 'itemproduct',
    schema: 'public',
    timestamps: false,
    indexes: [
      {
        name: "itemproduct_pkey",
        unique: true,
        fields: [
          { name: "cartid" },
        ]
      },
    ]
  });
  }
}
