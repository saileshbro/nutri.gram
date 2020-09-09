const validator = require("validator").default
const CustomError = require("./custom_error")
/**
 * Throws `CustomError` if name is null or invalid
 * @param {String} name
 * @throws `CustomError`
 */
exports.validateName = (name) => {
  const regName = /^[a-zA-Z][a-zA-Z\s]*$/
  if (!name || !regName.test(name)) {
    throw new CustomError(406, "Invalid name provided!")
  }
}

/**
 * Throws `CustomError` if password is null or invalid
 * @param {String} password
 * @throws `CustomError`
 */
exports.validatePassword = (password) => {
  const regName = /^(?:(?=.*[a-z])(?:(?=.*[A-Z])(?=.*[\d\W])|(?=.*\W)(?=.*\d))|(?=.*\W)(?=.*[A-Z])(?=.*\d)).{8,}$/
  if (!password || !regName.test(password)) {
    throw new CustomError(
      406,
      `Invalid Password.
    Required: Minimum eight characters, at least one letter, one number and one special character.`
    )
  }
}
/**
 * Throws `CustomError` if phone number is null or invalid
 * @param {String} phoneNumber
 * @throws `CustomError`
 */
exports.validatePhone = (phoneNumber) => {
  if (!phoneNumber || !validator.isMobilePhone(phoneNumber) || phoneNumber.length < 10) {
    throw new CustomError(406, "Invalid phone number provided!")
  }
}
/**
 * Throws `CustomError` if otp is null or invalid
 * @param {String} phoneNumber
 * @throws `CustomError`
 */
exports.validateOtp = (otp) => {
  if (otp.length !== 4 || !validator.isNumeric(otp)) {
    throw new CustomError(406, "Invalid OTP provided!")
  }
}
exports.validateURL = (url) => {
  try {
    // eslint-disable-next-line no-unused-vars
    const tryUrl = new URL(url)
  } catch (error) {
    throw new CustomError(400, "Invalid URL provided")
  }
}
