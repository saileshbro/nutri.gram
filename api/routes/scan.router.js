const router = require("express").Router()
const { catchErrors } = require("../handlers/error_handler")
const { scanImage, saveScanResult, getScanHistory } = require("../controllers/scan.controller")
const auth = require("../middleware/auth")
const { uploadScan } = require("../helpers/file_upload")

router.post("/scans/get_scan_result", uploadScan("scan_image"), catchErrors(scanImage))
router.post("/scans/save_scan_result", auth, catchErrors(saveScanResult))
router.get("/scans/get_scan_history", auth, catchErrors(getScanHistory))
module.exports = router
