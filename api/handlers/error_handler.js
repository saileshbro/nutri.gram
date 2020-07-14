class ValidationError extends Error {
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

/**
 * Error Handler
 */
exports.catchErrors = fn => {

  return (req, res, next) => {

    fn(req, res, next).catch(err => {
      if (typeof err === "string") {
        return res.status(400).json({
          error: err
        })
      }
      if (err instanceof ValidationError) {
        return res.status(err.statusCode || 500).json({
          error: err.error
        })
      }
      return next(err)
    })
  }
}

/**
 * MongoDB Validations Error Handler
 *
 */
exports.mongooseErrors = (err, req, res, next) => {

  if (!err.errors) return next(err)
  const keys = Object.keys(err.errors)
  let message = ""
  keys.forEach((key) => {
    message += `${err.errors[key].message}, `
  })
  message = message.substr(0, message.length - 2)

  return res.status(400).json({
    message,
  })
}
/**
 * Development Error Handler
 */
exports.developmentErrors = (err, req, res, next) => {
  const {
    message: error,
    status
  } = err
  const errorDetails = {
    error,
    status,
    stack: err.stack || ""
  }
  return res.status(status || 500).json(errorDetails)
}
exports.productionErrors = (err, req, res, next) => {
  return res.status(err.status || 500).json({
    error: "Internal Server Error"
  })
}
exports.notFoundError = (req, res) => {
  return res.status(404).json({
    error: "Route not found"
  })
}
exports.ValidationError = ValidationError
