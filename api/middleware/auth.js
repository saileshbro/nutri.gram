const jwt = require("jsonwebtoken")
const User = require("../models/User")
const CustomError = require("../handlers/custom_error")
const {
  catchErrors
} = require("../handlers/error_handler")

module.exports =
  catchErrors(
    /**
     * @param {Request} req
     * @param {Response} res
     * @param {NextFunction} next
     */
    async (req, res, next) => {
      if (!req.headers.authorization || req.headers.authorization === "Bearer null") {
        throw new CustomError(401, "Please authenticate.")
      }
      const token = req.headers.authorization.replace("Bearer ", "")
      const {
        _id
      } = jwt.verify(token, process.env.JWT_SECRET)
      const user = await User.findOne(
        _id
      )
      if (!user) throw new CustomError(401, "Please authenticate.")
      req.token = token
      req.user = user
    })
