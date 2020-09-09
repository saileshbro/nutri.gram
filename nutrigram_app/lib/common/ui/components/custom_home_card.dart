import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/components/d_raised_button.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/constants/strings.dart';
import 'package:nutrigram_app/ui/views/home/home_viewmodel.dart';
import 'package:stacked/stacked.dart';

class CustomHomeCard extends ViewModelWidget<HomeViewModel> {
  @override
  Widget build(BuildContext context, HomeViewModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: homeCardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: !model.hasScannedData
              ? Stack(
                  children: [
                    Container(
                      alignment: model.userDataService.isLoggedIn
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        margin: model.userDataService.isLoggedIn
                            ? const EdgeInsets.only(left: 8.0)
                            : const EdgeInsets.only(right: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: model.userDataService.isLoggedIn
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end,
                          children: [
                            if (!model.userDataService.isLoggedIn)
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: "Create an account",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: kFontFamily,
                                        fontSize: 18,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ".",
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: kFontFamily,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Save Scan",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: kFontFamily,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ".",
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: kFontFamily,
                                      fontSize: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            RichText(
                              text: const TextSpan(
                                children: [
                                  TextSpan(
                                    text: "Visualize Intake",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: kFontFamily,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ".",
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: kFontFamily,
                                      fontSize: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            lHeightSpan,
                            DRaisedButton(
                              title: model.userDataService.isLoggedIn
                                  ? scan
                                  : login,
                              hasBoxShadow: false,
                              loading: false,
                              isSmall: true,
                              onPressed: model.userDataService.isLoggedIn
                                  ? model.goToScan
                                  : model.goToLogin,
                            ),
                            sHeightSpan,
                          ],
                        ),
                      ),
                    ),
                    if (model.userDataService.isLoggedIn)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Image.asset(
                          homeIllustrationRight,
                          height: 200,
                        ),
                      )
                    else
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Image.asset(
                          homeIllustrationLeft,
                          height: 200,
                        ),
                      )
                  ],
                )
              : const Center(child: Text("Graph Here")),
        ),
        sHeightSpan,
        Container(
          child: model.userDataService.isLoggedIn
              ? model.hasScannedData
                  ? const Text(
                      "View More",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    )
                  : const Text(
                      "Update profile",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                        decoration: TextDecoration.underline,
                      ),
                    )
              : const Text(
                  "Scan right away",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: kPrimaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
        ),
      ],
    );
  }
}
