import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/HelperWidget/bottom_banner.dart';
import 'package:nutrigram_app/common/HelperWidget/busy_button.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/constants/strings.dart';

class RegisterView extends StatefulWidget {
  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool obscureText = true;

  FocusNode nameFocusNode;
  FocusNode phoneFocusNode;
  FocusNode passwordFocusNode;

  TextEditingController _phoneController, _nameController, _passwordController;

  @override
  void initState() {
    super.initState();
    nameFocusNode = FocusNode();
    phoneFocusNode = FocusNode();
    passwordFocusNode = FocusNode();

    _phoneController = TextEditingController();
    _nameController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: BottomBanner(
        onPressed: () {},
        bannerText: "Already have an account?",
        buttonLabel: "Login",
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: <Widget>[
          Navigator.canPop(context) ? AppBar() : SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Image.asset(
                    registerIllustration,
                    width: MediaQuery.of(context).size.width,
                  ),
                ),
                mHeightSpan,
                Text(
                  register,
                  style: Theme.of(context).textTheme.headline4,
                ),
                lHeightSpan,
                Form(
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        controller: _nameController,
                        style: Theme.of(context).textTheme.caption,
                        textCapitalization: TextCapitalization.words,
                        keyboardType: TextInputType.text,
                        focusNode: nameFocusNode,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(phoneFocusNode);
                        },
                        decoration: InputDecoration(
                          hintStyle: Theme.of(context)
                              .textTheme
                              .caption
                              .apply(color: kDisabledLightThemeColor),
                          prefixIcon: Icon(
                            Icons.perm_identity,
                          ),
                          hintText: fullName,
                        ),
                      ),
                      mHeightSpan,
                      TextFormField(
                        controller: _phoneController,
                        style: Theme.of(context).textTheme.caption,
                        focusNode: phoneFocusNode,
                        onEditingComplete: () {
                          FocusScope.of(context)
                              .requestFocus(passwordFocusNode);
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintStyle: Theme.of(context)
                              .textTheme
                              .caption
                              .apply(color: kDisabledLightThemeColor),
                          prefixIcon: Icon(
                            Icons.phone_android,
                          ),
                          hintText: phoneNumber,
                        ),
                      ),
                      mHeightSpan,
                      TextFormField(
                        controller: _passwordController,
                        style: Theme.of(context).textTheme.caption,
                        focusNode: passwordFocusNode,
                        onEditingComplete: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                        },
                        obscureText: obscureText,
                        decoration: InputDecoration(
                          hintStyle: Theme.of(context)
                              .textTheme
                              .caption
                              .apply(color: kDisabledLightThemeColor),
                          prefixIcon: Icon(
                            Icons.lock_open,
                          ),
                          suffixIcon: Material(
                            type: MaterialType.transparency,
                            shape: CircleBorder(),
                            child: InkWell(
                              customBorder: CircleBorder(),
                              child: Icon(obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              onTap: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                            ),
                          ),
                          hintText: password,
                        ),
                      ),
                      llHeightSpan,
                      Container(
                        decoration: BoxDecoration(
                          boxShadow: getBoxShadow(
                            context,
                            kPrimaryColor,
                          ),
                        ),
                        width: double.infinity,
                        child: BusyButton(
                          color: kPrimaryColor,
                          title: (register), onPressed: () {},
                          // busy: model.busy,
                          // onPressed: model.busy
                          //     ? null
                          //     : () {
                          //         model.register(
                          //           _nameController.text,
                          //           _phoneController.text,
                          //           _passwordController.text,
                          //         );
                          //       },
                        ),
                      ),
                      // mHeightSpan,
                      FlatButton(
                        onPressed: () {},
                        splashColor: Colors.transparent,
                        child: Text(
                          alreadyHaveAnAccount,
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          mHeightSpan,
        ],
      ),
    );
  }
}
