const {
  Schema,
  model
} = require("mongoose")
const bcrypt = require("bcryptjs")
const jwt = require("jsonwebtoken")
const moment = require("moment")
const CustomError = require("../handlers/custom_error")

const userSchema = new Schema({
  "name": {
    type: String,
    required: "Name is required!",
    trim: true,
  },
  email: {
    type: String,
    required: "Email is required!",
    trim: true,
    lowercase: true,
    unique: true,
  },
  password: {
    type: String,
    required: "Password is required!",
  },
  phone: {
    type: String,
    required: "Phone number is required!"
  }
}, {
  timestamps: true,
})

userSchema.pre("save", async function (next) {
  const user = this
  if (user.isModified("password")) {
    user.password = await bcrypt.hash(user.password, parseInt(process.env.SALT_ROUNDS, 10))
  }
  next()
})
/**
 * @returns `token`
 */
userSchema.methods.generateAuthToken = async function () {
  const user = this
  const token = await jwt.sign({
    _id: user._id.toString(),
  }, process.env.JWT_SECRET)
  return token
}
userSchema.methods.toJSON = function () {
  const user = this
  const userObject = user.toObject()
  userObject.createdAt = moment(userObject.createdAt).format("ddd, d MMM YYYY")
  userObject.updatedAt = moment(userObject.updatedAt).format("ddd, d MMM YYYY")
  delete userObject.password
  return userObject
}
/**
 *
 * @param {String} email
 * @param {String} password
 * @throws `Error` if email or password invalid
 * @returns `User`
 */
userSchema.statics.findByCredentials = async (email, password) => {
  // eslint-disable-next-line no-use-before-define
  const user = await model("User", userSchema).findOne({
    email
  })
  if (!user) throw new CustomError(401, "Invalid email or password!")

  const isMatch = await bcrypt.compare(password, user.password)
  if (!isMatch) throw new CustomError(401, "Invalid email or password!")
  return user
}

const User = model("User", userSchema)
module.exports = User
