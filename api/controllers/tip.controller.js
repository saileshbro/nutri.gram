const axios = require('axios')
const Tip = require("../models/Tip")

const CustomError = require("../handlers/custom_error");
const {
  validateURL
} = require("../handlers/custom_validators");
const downloadImage = require('../helpers/download_image');
/**
 * @param {Request} req
 * @param {Response} res
 */
exports.addTip = async (req, res) => {
  const {
    title,
    description,
    imageUrl
  } = req.body
  validateURL(imageUrl)
  const isExists = await Tip.findOne({
    title
  });
  if (isExists)
    throw new CustomError(400, `Tip with title '${title}' already exists`)

  const tip = await Tip.create({
    title,
    description,
    imageUrl
  })

  return res.json({
    message: "Created successfully!",
    tip
  })
}
/**
 * @param {Request} req
 * @param {Response} res
 */
exports.getTips = async (req, res) => {
  const tips = await Tip.where({});
  console.log(tips)
  return res.json({
    tips
  })
}
