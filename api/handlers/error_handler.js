const CustomError = require("./custom_error")
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
      if (err instanceof CustomError) {
        return res.status(err.statusCode || 500).json({
          error: err.error
        })
      }
      return next(err)
    })
  }
}

/**
 * Mongoose Validation Error Handler
 * @param {*} err
 * @param {Request} req
 * @param {Response} res
 * @param {*} next
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
 * @param {*} err
 * @param {Request} req
 * @param {Response} res
 * @param {*} next
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
/**
 * Production Error Handler
 * @param {*} err
 * @param {Request} req
 * @param {Response} res
 * @param {*} next
 */
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
