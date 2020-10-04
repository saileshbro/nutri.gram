import 'package:flutter/material.dart';

import 'package:nutrigram_app/common/ui/components/d_raised_button.dart';
import 'package:nutrigram_app/common/ui/components/nutrient_bar_graph.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/constants/strings.dart';
import 'package:nutrigram_app/datamodels/nutrient.dart';

class CustomHomeCard extends StatelessWidget {
  final bool isLoggedin;
  final VoidCallback onLoginPressed;
  final VoidCallback onScanPressed;
  final VoidCallback onGotoGraphPressed;
  final VoidCallback onProfilePressed;
  final List<Nutrient> allScannedData;
  const CustomHomeCard({
    Key key,
    this.isLoggedin,
    this.onLoginPressed,
    this.onScanPressed,
    this.allScannedData,
    this.onGotoGraphPressed,
    this.onProfilePressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: 200,
          decoration: BoxDecoration(
            color: allScannedData.isNotEmpty ? Colors.white : homeCardColor,
            borderRadius: BorderRadius.circular(8),
          ),
          child: !allScannedData.isNotEmpty
              ? Stack(
                  children: [
                    Container(
                      alignment: isLoggedin
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        margin: isLoggedin
                            ? const EdgeInsets.only(left: 8.0)
                            : const EdgeInsets.only(right: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: isLoggedin
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end,
                          children: [
                            if (!isLoggedin)
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
                              title: isLoggedin ? scan : login,
                              hasBoxShadow: false,
                              loading: false,
                              isSmall: true,
                              onPressed:
                                  isLoggedin ? onScanPressed : onLoginPressed,
                            ),
                            sHeightSpan,
                          ],
                        ),
                      ),
                    ),
                    if (isLoggedin)
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
              : NutrientBarGraph(
                  nutrients: allScannedData,
                  onlyMacro: true,
                ),
        ),
        sHeightSpan,
        Container(
          child: isLoggedin
              ? allScannedData.isNotEmpty
                  ? GestureDetector(
                      onTap: onGotoGraphPressed,
                      child: const Text(
                        "View More",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: onProfilePressed,
                      child: const Text(
                        "Update profile",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: kPrimaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
              : GestureDetector(
                  onTap: onScanPressed,
                  child: const Text(
                    "Scan right away",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
