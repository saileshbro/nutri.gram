const {
  addTip,
  getTips
} = require("../controllers/tip.controller")
const {
  catchErrors
} = require("../handlers/error_handler")

const router = require("express").Router()
router
  .get('/tips', catchErrors(getTips))
  .post('/tips', catchErrors(addTip));
module.exports = router
