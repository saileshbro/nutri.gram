const { default: Axios } = require("axios")
const FormData = require("form-data")
const CustomError = require("../handlers/custom_error")
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
