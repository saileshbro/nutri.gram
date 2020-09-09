const { Schema, model } = require("mongoose")
const moment = require("moment")

const tipSchema = new Schema(
  {
    title: {
      type: String,
      required: "Title for tip is required!",
      trim: true,
    },
    description: {
      type: String,
      required: "Description for tip is required!",
      trim: true,
    },
    imageUrl: {
      type: String,
      required: "Image is required!",
      trim: true,
    },
  },
  {
    timestamps: true,
  }
)
tipSchema.methods.toJSON = function () {
  const tip = this
  const tipObject = tip.toObject()
  tipObject.createdAt = moment(tipObject.createdAt).format("ddd, d MMM YYYY")
  tipObject.updatedAt = moment(tipObject.updatedAt).format("ddd, d MMM YYYY")
  delete tipObject.__v
  return tipObject
}
const Tip = model("Tip", tipSchema)
module.exports = Tip
