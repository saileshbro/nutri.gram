const nutritionixApi = require("nutritionix-api")
const CustomError = require("../handlers/custom_error")
const nutritionixDataMapper = require("../handlers/nutritionix_response_filter")

nutritionixApi.init(process.env.NUTRITIONIX_APP_ID, process.env.NUTRITIONIX_API_KEY)
/**
 * Searches for the food nutrients from a search query
 * @param {Request} req
 * @param {Response} res
 */
exports.searchFoodNutrients = async (req, res) => {
  const query = req.query.q

  const response = await nutritionixApi.natural.search(query)
  if (response.message) {
    throw new CustomError(400, response.message)
  }
  const { foods } = response
  return res.json(nutritionixDataMapper(foods[0]))
}
