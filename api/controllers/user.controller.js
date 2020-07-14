const {
  validateEmail,
  validateName,
  validatePassword,
  validatePhone
} = require("../handlers/custom_validators")
const User = require("../models/User")
/**
 *
 * @param {Request} req
 * @param {Response} res
 * @param {import("express").NextFunction} next
 */
exports.signup = async (req, res) => {
  const {
    email,
    name,
    password,
    phone
  } = req.body
  // validate fields
  validateEmail(email)
  validateName(name)
  validatePassword(password)
  validatePhone(phone)
  const isExist = await User.findOne({
    email
  })
  if (isExist) {
    throw new Error(`Account with email ${email} already exists`)
  }
  const user = new User({
    email,
    name,
    password,
    phone
  })
  await user.save()
  const token = await user.generateAuthToken()
  return res.json({
    user,
    token
  })
}
exports.login = async (req, res) => {
  const {
    email,
    password
  } = req.body
  const user = await User.findByCredentials(email, password)
  const token = await user.generateAuthToken()
  return res.json({
    user,
    token
  })
}
