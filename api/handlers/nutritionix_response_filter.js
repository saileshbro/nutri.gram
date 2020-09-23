const nutritionixDataMapper = (nutritionixFoodObject) => {
  const response = {}
  const data = []
  response.foodName = nutritionixFoodObject.food_name
  data.push(
    {
      total: Math.ceil(nutritionixFoodObject.serving_weight_grams),
      unit: "g",
    },
    {
      calories: Math.ceil(nutritionixFoodObject.nf_calories),
      unit: "kcal",
    },
    {
      fat: nutritionixFoodObject.nf_total_fat,
      unit: "g",
    },
    {
      saturatedFat: nutritionixFoodObject.nf_saturated_fat,
      unit: "g",
    },
    {
      cholesterol: nutritionixFoodObject.nf_cholesterol,
      unit: "mg",
    },
    {
      sodium: nutritionixFoodObject.nf_sodium,
      unit: "mg",
    },
    {
      carbohydrate: nutritionixFoodObject.nf_total_carbohydrate,
      unit: "g",
    },
    {
      dietaryFiber: nutritionixFoodObject.nf_dietary_fiber,
      unit: "g",
    },
    {
      sugar: nutritionixFoodObject.nf_sugars,
      unit: "g",
    },
    {
      protein: nutritionixFoodObject.nf_protein,
      unit: "g",
    },
    {
      potassium: nutritionixFoodObject.nf_potassium,
      unit: "mg",
    },
    {
      phosphorous: nutritionixFoodObject.nf_p,
      unit: "mg",
    }
  )
  response.data = data
  return response
}
module.exports = nutritionixDataMapper
