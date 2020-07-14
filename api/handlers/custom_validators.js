const
  validator = require("validator").default
const {
  ValidationError
} = require("./error_handler")
/**
 *
 * @param {String} email
 * @throws `ValidationError`
 */
exports.validateEmail = (email) => {
  if (!email || !validator.isEmail(email)) {
    throw new ValidationError(406, "Invalid email provided!")
  }
}

/**
 * Throws `ValidationError` if name is null or invalid
 * @param {String} name
 * @throws `ValidationError`
 */
exports.validateName = (name) => {
  const regName = /^[a-zA-Z][a-zA-Z\s]*$/
  if (!name || !regName.test(name)) {
    throw new ValidationError(406, "Invalid name provided!")
  }
}

/**
 * Throws `ValidationError` if password is null or invalid
 * @param {String} password
 * @throws `ValidationError`
 */
exports.validatePassword = (password) => {
  const regName = /^(?:(?=.*[a-z])(?:(?=.*[A-Z])(?=.*[\d\W])|(?=.*\W)(?=.*\d))|(?=.*\W)(?=.*[A-Z])(?=.*\d)).{8,}$/
  if (!password || !regName.test(password)) {
    throw new ValidationError(406, `Invalid Password.
    Required: Minimum eight characters, at least one letter, one number and one special character.`)
  }
}
/**
 * Throws `ValidationError` if phone number is null or invalid
 * @param {String} phoneNumber
 * @throws `ValidationError`
 */
exports.validatePhone = (phoneNumber) => {
  if (!phoneNumber || !validator.isMobilePhone(phoneNumber || phoneNumber.length < 10)) {
    throw new ValidationError(406, "Invalid phone number provided!")
  }
}
