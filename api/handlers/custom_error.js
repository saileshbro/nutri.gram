class CustomError extends Error {
  /**
   *
   * @param {Number} statusCode
   * @param {String} error
   */
  constructor(statusCode, error) {
    super()
    this.statusCode = statusCode
    this.error = error
  }
}
module.exports = CustomError
