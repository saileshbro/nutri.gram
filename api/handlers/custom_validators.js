const
  validator = require("validator").default
const CustomError = require("./custom_error")
/**
 *
 * @param {String} email
 * @throws `CustomError`
 */
exports.validateEmail = (email) => {
  if (!email || !validator.isEmail(email)) {
    throw new CustomError(406, "Invalid email provided!")
  }
}

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
    throw new CustomError(406, `Invalid Password.
    Required: Minimum eight characters, at least one letter, one number and one special character.`)
  }
}
/**
 * Throws `CustomError` if phone number is null or invalid
 * @param {String} phoneNumber
 * @throws `CustomError`
 */
exports.validatePhone = (phoneNumber) => {
  if (!phoneNumber || !validator.isMobilePhone(phoneNumber || phoneNumber.length < 10)) {
    throw new CustomError(406, "Invalid phone number provided!")
  }
}
