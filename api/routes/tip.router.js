const { Router } = require("express")
const { addTip, getTips } = require("../controllers/tip.controller")
const { catchErrors } = require("../handlers/error_handler")

const router = Router()

router.get("/tips", catchErrors(getTips)).post("/tips", catchErrors(addTip))
module.exports = router
