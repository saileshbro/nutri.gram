const router = require("express").Router()
const { catchErrors } = require("../handlers/error_handler")
const { scanImage } = require("../controllers/scan.controller")
// eslint-disable-next-line no-unused-vars
const auth = require("../middleware/auth")
const { uploadScan } = require("../helpers/file_upload")

router.post("/scans/get_scan_result", uploadScan("scan_image"), catchErrors(scanImage))
module.exports = router
