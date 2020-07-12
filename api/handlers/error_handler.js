require("express")
/**
 * Error Handler
 */
exports.catchErrors = fn => {
  return (req, res, next) => {
    fn(req, res, next).catch(err => {
      if (typeof err === "string") {
        return res.status(400).json({
          message: err
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
    message,
    status
  } = err
  const errorDetails = {
    message,
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
    message: "Route not found"
  })
}
