const multer = require("multer")
const path = require("path")

const imageStorage = multer.diskStorage({
  destination(req, file, cb) {
    cb(null, "public/uploads/images")
  },
  filename(req, file, cb) {
    cb(
      null,
      `${file.fieldname + Date.now()}.${
        file.originalname.toLowerCase().split(".")[file.originalname.split(".").length - 1]
      }`
    )
  },
})
/**
 * Takes the form name for the single image
 * @param {String} imageName
 */
const uploadImage = (imageName) =>
  multer({
    storage: imageStorage,
    fileFilter(req, file, callback) {
      const ext = path.extname(file.originalname.toLowerCase())
      if (ext !== ".png" && ext !== ".jpg" && ext !== ".jpeg") {
        return callback({
          error: "Only images are allowed",
        })
      }
      return callback(null, true)
    },
  }).single(imageName)
/**
 * Takes the form name for the single scan image
 * @param {String} imageName
 */
const uploadScan = (imageName) =>
  multer({
    fileFilter(req, file, callback) {
      const ext = path.extname(file.originalname.toLowerCase())
      if (ext !== ".png" && ext !== ".jpg" && ext !== ".jpeg") {
        return callback({
          error: "Only images are allowed",
        })
      }
      return callback(null, true)
    },
  }).single(imageName)
module.exports = { uploadImage, uploadScan }
