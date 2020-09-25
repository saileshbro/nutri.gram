const { default: Axios } = require("axios")
const FormData = require("form-data")
const CustomError = require("../handlers/custom_error")
const ScannedItem = require("../models/ScannedItem")
/**
 * scans image fetches image content from ML server at :5000 port
 * @param {Request} req
 * @param {Response} res
 */
exports.scanImage = async (req, res) => {
  if (!req.file) {
    throw new CustomError(400, "Please provide an image!")
  }
  const bufferObject = Buffer.from(req.file.buffer)
  const file = new FormData()
  file.append("image", bufferObject, `image.${req.file.mimetype.split("/")[1]}`)
  const fullUrl = `${req.protocol}://${req.host}`
  console.log(fullUrl)

  const resp = await Axios.post(`${fullUrl}:5000/upload`, file, { headers: file.getHeaders() }).catch(() => {
    throw new CustomError(500, "Error while fetching data from image scanning server!")
  })
  if (res.status >= 400) {
    throw new CustomError(500, "Error while fetching data from image scanning server!")
  }
  const { data } = resp.data
  return res.json({ data })
}
/**
 * @param {Request} req
 * @param {Response} res
 */
exports.saveScanResult = async (req, res) => {
  const { data, foodName, searchTerm } = req.body
  let calorieValue = 0
  const isExists = await ScannedItem.find({
    $and: [
      {
        userId: req.user._id,
        foodName,
      },
      {
        userId: req.user._id,
        searchTerm,
      },
    ],
  })
  if (isExists.length > 0) {
    throw new CustomError(400, "Already exists!")
  }
  data.forEach((e) => {
    if (e.unit.toLowerCase() === "kcal") {
      calorieValue = e.value
    }
  })
  const scannedItem = new ScannedItem({
    userId: req.user._id,
    foodName,
    data,
    searchTerm,
  })
  req.user.addCalories(calorieValue)
  req.user.incrementSaved()
  await scannedItem.save()
  await req.user.save()
  return res.json({
    message: "Saved successfully!",
  })
}
exports.getScanHistory = async (req, res) => {
  const history = await ScannedItem.where({
    userId: req.user._id,
  })
  return res.json({ history })
}
exports.removeFromHistory = async (req, res) => {
  const { _id } = req.body
  await ScannedItem.deleteOne({
    _id,
    userId: req.user._id,
  })
  return res.json({ message: "Deleted successfully!" })
}
