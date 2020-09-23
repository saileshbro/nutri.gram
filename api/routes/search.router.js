const router = require("express").Router()
const { searchFoodNutrients } = require("../controllers/search.controller")
const { catchErrors } = require("../handlers/error_handler")

router.get("/search", catchErrors(searchFoodNutrients))
module.exports = router
