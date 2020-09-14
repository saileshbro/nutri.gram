const router = require("express").Router()

const {
  signup,
  login,
  verifyOtp,
  resendVerificationOtp,
  generateForgotPasswordOtp,
  generateNewPasswordWithOtp,
  changePassword,
  updateProfile,
  updatePhone,
  getMyProfile,
  updateAvatar,
} = require("../controllers/user.controller")
const { catchErrors } = require("../handlers/error_handler")
const { uploadImage } = require("../helpers/file_upload")
const auth = require("../middleware/auth")

router.post("/users/login", catchErrors(login))
router.post("/users/signup", catchErrors(signup))
router.post("/users/verify_otp", catchErrors(verifyOtp))
router.post("/users/resend_otp", catchErrors(resendVerificationOtp))
router.post("/users/forgot_password/get_otp", catchErrors(generateForgotPasswordOtp))
router.post("/users/forgot_password/reset_password", catchErrors(generateNewPasswordWithOtp))
router.post("/users/change_password", auth, catchErrors(changePassword))
router.get("/users/me", auth, catchErrors(getMyProfile))
router.post("/users/update_profile", auth, catchErrors(updateProfile))
router.post("/users/update_phone", auth, catchErrors(updatePhone))
router.post("/users/update_avatar", auth, uploadImage("avatar"), catchErrors(updateAvatar))
module.exports = router
