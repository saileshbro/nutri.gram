import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/components/d_raised_button.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/constants/strings.dart';

class CustomHomeCard extends StatelessWidget {
  final bool hasScannedData;
  final bool isAuthenticated;
  const CustomHomeCard({
    this.hasScannedData = false,
    this.isAuthenticated = false,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 200,
          color: homeCardColor,
          child: !hasScannedData
              ? Stack(
                  children: [
                    Container(
                      alignment: isAuthenticated
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: isAuthenticated
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.end,
                          children: [
                            if (!isAuthenticated)
                              RichText(
                                text: const TextSpan(
                                  children: [
                                    TextSpan(
                                      text: " Create an account",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                    TextSpan(
                                      text: ".",
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
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
                                    text: " Save Scan",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ".",
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
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
                                    text: " Visualize Intake",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ".",
                                    style: TextStyle(
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            lHeightSpan,
                            DRaisedButton(
                              title: isAuthenticated ? scan : login,
                              hasBoxShadow: false,
                              loading: false,
                              isSmall: true,
                              onPressed: () {},
                            ),
                            sHeightSpan,
                          ],
                        ),
                      ),
                    ),
                    if (isAuthenticated)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Image.asset(
                          homeIllustrationRight,
                          height: 200,
                          width: 200,
                        ),
                      )
                    else
                      Positioned(
                        left: 0,
                        bottom: 0,
                        child: Image.asset(
                          homeIllustrationLeft,
                          height: 200,
                          width: 200,
                        ),
                      )
                  ],
                )
              : const Text("Graph Here"),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: isAuthenticated
                  ? hasScannedData
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
        ),
      ],
    );
  }
}
