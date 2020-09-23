const nutritionixDataMapper = (nutritionixFoodObject) => {
  const response = {}
  const data = []
  response.foodName = nutritionixFoodObject.food_name
  data.push(
    {
      type: "Total",
      value: Math.ceil(nutritionixFoodObject.serving_weight_grams),
      unit: "g",
    },
    {
      type: "Calories",
      value: Math.ceil(nutritionixFoodObject.nf_calories),
      unit: "kcal",
    },
    {
      type: "Fat",
      value: nutritionixFoodObject.nf_total_fat,
      unit: "g",
    },
    {
      type: "Saturated Fat",
      value: nutritionixFoodObject.nf_saturated_fat,
      unit: "g",
    },
    {
      type: "Cholesterol",
      value: nutritionixFoodObject.nf_cholesterol,
      unit: "mg",
    },
    {
      type: "Sodium",
      value: nutritionixFoodObject.nf_sodium,
      unit: "mg",
    },
    {
      type: "Carbohydrate",
      value: nutritionixFoodObject.nf_total_carbohydrate,
      unit: "g",
    },
    {
      type: "Dietary Fiber",
      value: nutritionixFoodObject.nf_dietary_fiber,
      unit: "g",
    },
    {
      type: "Sugar",
      value: nutritionixFoodObject.nf_sugars,
      unit: "g",
    },
    {
      type: "Protein",
      value: nutritionixFoodObject.nf_protein,
      unit: "g",
    },
    {
      type: "Potassium",
      value: nutritionixFoodObject.nf_potassium,
      unit: "mg",
    },
    {
      type: "Phosphorous",
      value: nutritionixFoodObject.nf_p,
      unit: "mg",
    }
  )
  response.data = data
  return response
}
module.exports = nutritionixDataMapper
