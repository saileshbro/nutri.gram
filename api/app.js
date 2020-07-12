require("dotenv").config()
require("./database")
const express = require("express")
const path = require("path")
const cookieParser = require("cookie-parser")
const logger = require("morgan")
const {
  developmentErrors,
  productionErrors,
  notFoundError,
  mongooseErrors
} = require("./handlers/error_handler")

const app = express()
app.use(logger("tiny"))
app.use(express.json())
app.use(
  express.urlencoded({
    extended: false,
  })
)
app.use(cookieParser())
app.use(express.static(path.join(__dirname, "public")))

// Error handlers setup
app.use(notFoundError)
app.use(mongooseErrors)
if (process.env.NODE_ENV === "development") {
  app.use(developmentErrors)
} else {
  app.use(productionErrors)
}
module.exports = app
