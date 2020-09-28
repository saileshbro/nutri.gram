const nutritionixDataMapper = (nutritionixFoodObject) => {
  const response = {}
  response.foodName = nutritionixFoodObject.food_name
  response.imageUrl = nutritionixFoodObject.photo.highres
  const mgData = [
    {
      type: "Cholesterol",
      value: nutritionixFoodObject.nf_cholesterol ? nutritionixFoodObject.nf_cholesterol : 0,
      unit: "mg",
    },
    {
      type: "Sodium",
      value: nutritionixFoodObject.nf_sodium ? nutritionixFoodObject.nf_sodium : 0,
      unit: "mg",
    },

    {
      type: "Potassium",
      value: nutritionixFoodObject.nf_potassium ? nutritionixFoodObject.nf_potassium : 0,
      unit: "mg",
    },
    {
      type: "Phosphorous",
      value: nutritionixFoodObject.nf_p ? nutritionixFoodObject.nf_p : 0,
      unit: "mg",
    },
  ]
  const gData = [
    {
      type: "Fat",
      value: nutritionixFoodObject.nf_total_fat ? nutritionixFoodObject.nf_total_fat : 0,
      unit: "g",
    },
    {
      type: "Saturated Fat",
      value: nutritionixFoodObject.nf_saturated_fat ? nutritionixFoodObject.nf_saturated_fat : 0,
      unit: "g",
    },
    {
      type: "Carbohydrate",
      value: nutritionixFoodObject.nf_total_carbohydrate ? nutritionixFoodObject.nf_total_carbohydrate : 0,
      unit: "g",
    },
    {
      type: "Dietary Fiber",
      value: nutritionixFoodObject.nf_dietary_fiber ? nutritionixFoodObject.nf_dietary_fiber : 0,
      unit: "g",
    },
    {
      type: "Sugar",
      value: nutritionixFoodObject.nf_sugars ? nutritionixFoodObject.nf_sugars : 0,
      unit: "g",
    },
    {
      type: "Protein",
      value: nutritionixFoodObject.nf_protein ? nutritionixFoodObject.nf_protein : 0,
      unit: "g",
    },
  ]
  response.data = [
    {
      type: "Calories",
      value: Math.ceil(nutritionixFoodObject.nf_calories),
      unit: "kcal",
    },
    {
      type: "Total",
      value: Math.ceil(nutritionixFoodObject.serving_weight_grams),
      unit: "g",
    },
    ...gData.sort((a, b) => b.value - a.value),
    ...mgData.sort((a, b) => b.value - a.value),
  ]
  return response
}
module.exports = nutritionixDataMapper
