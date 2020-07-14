module.exports = {
  env: {
    commonjs: true,
    es2020: true,
    node: true,
  },
  extends: ["airbnb-base", "prettier"],
  parserOptions: {
    ecmaVersion: 11,
  },
  plugins: ["prettier"],
  rules: {
    "no-unused-vars": [
      "error",
      {
        // ignoreSiblings: true,
        argsIgnorePattern: "req|res|next|Link|^err",
      },
    ],
    "no-console": "off",
    quotes: ["error", "double"],
    semi: ["error", "never"],
    "func-names": "off",
    "no-underscore-dangle": "off"
  },
}
