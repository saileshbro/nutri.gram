const router = require("express").Router()
const { catchErrors } = require("../handlers/error_handler")
const {
  scanImage,
  saveScanResult,
  getScanHistory,
  removeFromHistory,
  getTotalScanned,
} = require("../controllers/scan.controller")
const auth = require("../middleware/auth")
const { uploadScan } = require("../helpers/file_upload")

router.post("/scans/get_scan_result", uploadScan("scan_image"), catchErrors(scanImage))
router.post("/scans/save_scan_result", auth, catchErrors(saveScanResult))
router.get("/scans/get_total_scanned", auth, catchErrors(getTotalScanned))
router.post("/scans/remove_from_history", auth, catchErrors(removeFromHistory))
router.get("/scans/get_scan_history", auth, catchErrors(getScanHistory))
module.exports = router
