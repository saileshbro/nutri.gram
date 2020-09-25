const { Schema, model } = require("mongoose")

const scannedItemSchema = new Schema(
  {
    foodName: {
      type: String,
      required: "Food name is required!",
      trim: true,
    },
    searchTerm: {
      type: String,
      default: "",
    },
    userId: {
      type: Schema.Types.ObjectId,
      ref: "User",
    },
    data: [
      {
        type: {
          type: String,
        },
        value: {
          type: Schema.Types.Number,
          default: 0,
        },
        unit: {
          type: String,
        },
      },
    ],
  },
  {
    timestamps: true,
  }
)
scannedItemSchema.methods.toJSON = function () {
  const tip = this
  const onj = tip.toObject()
  delete onj.__v
  delete onj.updatedAt
  return onj
}
const ScannedItem = model("ScannedItem", scannedItemSchema)
module.exports = ScannedItem
