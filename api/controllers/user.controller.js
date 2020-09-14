const { validateName, validatePassword, validatePhone, validateOtp } = require("../handlers/custom_validators")
const User = require("../models/User")
const CustomError = require("../handlers/custom_error")
const generateOTP = require("../helpers/generate_otp")

const _changePw = async (req) => {
  const { currentPassword, newPassword } = req.body
  if (currentPassword === newPassword) {
    throw new CustomError(400, "Both passwords provided are same!")
  }
  validatePassword(currentPassword)
  validatePassword(newPassword)
  const isPassword = await req.user.isPassword(currentPassword)
  if (!isPassword) {
    throw new CustomError(400, "Current password doesn't match!")
  }
  req.user.password = newPassword
}

/**
 *
 * @param {Request} req
 * @param {Response} res
 */
exports.signup = async (req, res) => {
  const { name, password, phone } = req.body
  validateName(name)
  validatePassword(password)
  validatePhone(phone)
  const isExist = await User.findOne({
    phone,
  })
  if (isExist) {
    throw new CustomError(406, "Account already exists with this number!")
  }

  const user = new User({
    name,
    password,
    phone,
    otp: generateOTP(),
  })
  await user.save()
  return res.json({
    message: "Please verify your OTP",
    user,
  })
}
/**
 *
 * @param {Request} req
 * @param {Response} res
 */
exports.login = async (req, res) => {
  const { password, phone } = req.body
  validatePhone(phone)
  validatePassword(password)
  const user = await User.findByCredentials(phone, password)
  const response = {}
  if (user.otpVerified) {
    const token = await user.generateAuthToken()
    response.user = user
    response.token = token
    response.message = "Login successful!"
  } else {
    response.user = user
    response.message = "Please verify your OTP!"
  }
  return res.json(response)
}
/**
 *
 * @param {Request} req
 * @param {Response} res
 */
exports.verifyOtp = async (req, res) => {
  const { phone, otp } = req.body
  validatePhone(phone)
  validateOtp(otp)
  const user = await User.findOne({
    phone,
    otp,
    otpVerified: false,
  })
  if (!user) {
    throw new CustomError(404, "Invalid OTP provided.")
  }
  user.otpVerified = true
  user.otp = generateOTP()
  await user.save()
  const token = await user.generateAuthToken()

  return res.json({
    user,
    token,
    message: "OTP verification successful!",
  })
}

/**
 *
 * @param {Request} req
 * @param {Response} res
 */
exports.resendVerificationOtp = async (req, res) => {
  const { phone } = req.body
  validatePhone(phone)
  const user = await User.findOne({
    phone,
  })
  if (!user) {
    throw new CustomError(404, "Invalid phone number provided!")
  }
  if (user.otpVerified) {
    throw new CustomError(406, "User already verified!")
  }
  user.otp = generateOTP()
  await user.save()
  return res.json({
    otp: user.otp,
    message: "OTP send successfully!",
  })
}
/**
 *
 * @param {Request} req
 * @param {Response} res
 */
exports.generateForgotPasswordOtp = async (req, res) => {
  const { phone } = req.body
  validatePhone(phone)
  const user = await User.findOne({
    phone,
  })
  if (!user) {
    throw new CustomError(404, `User with phone number ${phone} not found!`)
  }
  user.passwordResetOtp = generateOTP()
  await user.save()
  return res.json({
    message: "OTP has been sent to your phone!",
    otp: user.passwordResetOtp,
  })
}

/**
 * @param {Request} req
 * @param {Response} res
 */
exports.generateNewPasswordWithOtp = async (req, res) => {
  const { phone, otp, newPassword } = req.body
  validatePhone(phone)
  validatePassword(newPassword)
  validateOtp(otp)
  const user = await User.findOne({
    phone,
    passwordResetOtp: otp,
  })
  if (!user) {
    throw new CustomError(404, "Invalid OTP provided!")
  }
  user.password = newPassword
  await user.save()
  const token = await user.generateAuthToken()
  return res.json({
    message: "Password changed successfully!",
    user,
    token,
  })
}
/**
 * @param {Request} req
 * @param {Response} res
 */
exports.changePassword = async (req, res) => {
  await _changePw(req)
  await req.user.save()
  return res.json({
    message: "Password changed successfully!",
  })
}
/**
 * Updates profile with new fields
 * @param {Request} req
 * @param {Response} res
 */
exports.updateProfile = async (req, res) => {
  const { name, phone, newPassword } = req.body
  validateName(name)
  validatePhone(phone)
  if (req.user.phone !== phone) {
    console.log("phone number changed, send a new verification token")
    const user = await User.findByPhone(phone)
    if (user) {
      throw new CustomError(400, `User with phone ${phone} already exists`)
    }
    req.user.phoneChangeOtp = generateOTP()
  }
  req.user.name = name
  if (newPassword) {
    await _changePw(req)
  }
  await req.user.save()
  return res.json({
    user: req.user,
    otp: req.user.phoneChangeOtp,
    message: "Profile updated successfully!",
  })
}
/**
 * Update phone number
 * @param {Request} req
 * @param {Response} res
 */
exports.updatePhone = async (req, res) => {
  const { phone, otp } = req.body
  validateOtp(otp)
  validatePhone(phone)
  if (req.user.phone !== phone) {
    const user = await User.findByPhone(phone)
    if (user) {
      throw new CustomError(400, `User with phone ${phone} already exists`)
    }
    if (req.user.phoneChangeOtp === otp) {
      req.user.phone = phone
      await req.user.save()
      return res.json({
        user: req.user,
        message: "Phone changed successfully!",
      })
    }
    throw new CustomError(400, "OTP verification failure! Cannot change phone number!")
  }
  return res.json()
}
/**
 * Update user avatar
 * @param {Request} req
 * @param {Response} res
 */
exports.updateAvatar = async (req, res) => {
  if (!req.file) {
    throw new CustomError(400, "Please provide an image!")
  }
  req.user.imageUrl = req.file.path.replace(/\\/g, "/")
  await req.user.save()
  return res.json({
    user: req.user,
    message: "Avatar changed successfully!",
  })
}
/**
 * Get auth user profile
 * @param {Request} req
 * @param {Response} res
 */
exports.getMyProfile = async (req, res) => {
  return res.json(req.user)
}
