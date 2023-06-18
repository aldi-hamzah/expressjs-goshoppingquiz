import _sequelize from 'sequelize';
const { Model, Sequelize } = _sequelize;

export default class orderlineitem extends Model {
  static init(sequelize, DataTypes) {
  return super.init({
    ordlineid: {
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
    order: {
      type: DataTypes.UUID,
      allowNull: true,
      references: {
        model: 'orders',
        key: 'orderid'
      }
    }
  }, {
    sequelize,
    tableName: 'orderlineitem',
    schema: 'public',
    timestamps: false,
    indexes: [
      {
        name: "orderlineitem_pkey",
        unique: true,
        fields: [
          { name: "ordlineid" },
        ]
      },
    ]
  });
  }
}
