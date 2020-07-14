const router = require("express").Router()

const {
  signup,
  login
} = require("../controllers/user.controller")
const {
  catchErrors
} = require("../handlers/error_handler")

router.post("/users/login", catchErrors(login))
router.post("/users/signup", catchErrors(signup))
module.exports = router
