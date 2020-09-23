const { default: Axios } = require("axios")
const FormData = require("form-data")
const CustomError = require("../handlers/custom_error")

exports.scanImage = async (req, res) => {
  if (!req.file) {
    throw new CustomError(400, "Please provide an image!")
  }
  const { fieldName, buffer } = req.file
  const formData = new FormData()
  formData.append(fieldName, buffer)
  await Axios.post("url", formData, { headers: formData.getHeaders() })
}
