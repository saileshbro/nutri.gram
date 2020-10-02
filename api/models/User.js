const assert = require("assert")
const { Schema, model } = require("mongoose")
const bcrypt = require("bcryptjs")
const jwt = require("jsonwebtoken")
const moment = require("moment")
const CustomError = require("../handlers/custom_error")

const userSchema = new Schema(
  {
    name: {
      type: String,
      required: "Name is required!",
      trim: true,
    },
    imageUrl: {
      type: String,
      default: "public/profile.png",
    },
    password: {
      type: String,
      required: "Password is required!",
    },
    phone: {
      type: String,
      required: "Phone number is required!",
      trim: true,
      lowercase: true,
      unique: true,
    },
    passwordResetOtp: {
      type: String,
      default: "",
    },
    phoneChangeOtp: {
      type: String,
      default: "",
    },
    otp: {
      type: String,
      default: "",
    },
    otpVerified: {
      type: Boolean,
      default: false,
    },
    totalSaved: {
      type: Number,
      default: 0,
    },
    totalCalories: {
      type: Number,
      default: 0,
    },
  },
  {
    timestamps: true,
  }
)

userSchema.pre("save", async function (next) {
  const user = this
  if (user.isModified("password")) {
    user.password = await bcrypt.hash(user.password, parseInt(process.env.SALT_ROUNDS, 10))
  }
  next()
})
userSchema.methods.isPassword = async function (password) {
  const user = this
  const isPassword = await bcrypt.compare(password, user.password)
  return isPassword
}

userSchema.methods.generateAuthToken = async function () {
  const user = this
  const token = await jwt.sign(
    {
      _id: user._id.toString(),
    },
    process.env.JWT_SECRET
  )
  return token
}

userSchema.methods.toJSON = function () {
  const user = this
  const userObject = user.toObject()
  userObject.createdAt = moment(userObject.createdAt).format("ddd, d MMM YYYY")
  userObject.updatedAt = moment(userObject.updatedAt).format("ddd, d MMM YYYY")
  delete userObject.password
  delete userObject.__v
  return userObject
}
/**
 * Increments the saved count for the user
 */
userSchema.methods.incrementSaved = function () {
  const user = this
  user.totalSaved += 1
}
/**
 * Decrements the saved count for the user
 */
userSchema.methods.decrementSaved = function () {
  const user = this
  user.totalSaved -= 1
}
/**
 * added calories to the user, raises assertion error if negative or zero
 * @param {number} calories
 */
userSchema.methods.addCalories = function (calories = 0) {
  assert.equal(calories && calories >= 0, true, Error("Calories value cannot be negative"))
  this.totalCalories += calories
}
/**
 * added calories to the user, raises assertion error if negative or zero
 * @param {number} calories
 */
userSchema.methods.subtractCalories = function (calories = 0) {
  assert.equal(calories && calories >= 0, true, Error("Calories value cannot be negative"))
  this.totalCalories -= calories
}
/**
 *
 * @param {String} phone
 * @param {String} password
 * @throws `CustomError` if phone or password invalid
 * @returns `User`
 */
userSchema.statics.findByCredentials = async (phone, password) => {
  const user = await model("User", userSchema).findOne({
    phone,
  })
  if (!user) throw new CustomError(401, "Invalid credentials!")

  const isMatch = await bcrypt.compare(password, user.password)
  if (!isMatch) throw new CustomError(401, "Invalid credentials!")
  return user
}
userSchema.statics.findByPhone = async (phone) => {
  const user = await model("User", userSchema).findOne({
    phone,
  })
  return user
}
const User = model("User", userSchema)
module.exports = User
