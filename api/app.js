const dotenv = require("dotenv")

if (!process.env.NODE_ENV || process.env.NODE_ENV === "development") {
  dotenv.config()
}
require("./database")
const express = require("express")
const path = require("path")
const cookieParser = require("cookie-parser")
const logger = require("morgan")
const { developmentErrors, productionErrors, notFoundError, mongooseErrors } = require("./handlers/error_handler")

const app = express()
app.use(logger("tiny"))
app.use(express.json())

app.use(
  express.urlencoded({
    extended: false,
  })
)
app.use(cookieParser())
app.use("/public", express.static(path.join(__dirname, "public")))

// routes setup
app.use(
  "/api/v1",
  require("./routes/user.router"),
  require("./routes/tip.router"),
  require("./routes/scan.router"),
  require("./routes/search.router")
)
// Error handlers setup
app.use(notFoundError)
app.use(mongooseErrors)
if (process.env.NODE_ENV === "development") {
  app.use(developmentErrors)
} else {
  app.use(productionErrors)
}
module.exports = app
