import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/components/d_raised_button.dart';
import 'package:nutrigram_app/common/ui/components/nutrient_bar_graph.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/constants/strings.dart';
import 'package:nutrigram_app/datamodels/nutrient.dart';

class CustomHomeCard extends StatelessWidget {
  final bool isLoggedin;
  final VoidCallback? onLoginPressed;
  final VoidCallback? onScanPressed;
  final VoidCallback? onGotoGraphPressed;
  final VoidCallback? onProfilePressed;
  final List<Nutrient> allScannedData;

  const CustomHomeCard({
    Key? key,
    required this.isLoggedin,
    this.onLoginPressed,
    this.onScanPressed,
    this.onGotoGraphPressed,
    this.onProfilePressed,
    this.allScannedData = const [],
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
          child: allScannedData.isEmpty
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
                              _buildRichText("Create an account"),
                            _buildRichText("Save Scan"),
                            _buildRichText("Visualize Intake"),
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
                    Positioned(
                      right: isLoggedin ? 0 : null,
                      left: !isLoggedin ? 0 : null,
                      bottom: 0,
                      child: Image.asset(
                        isLoggedin
                            ? homeIllustrationRight
                            : homeIllustrationLeft,
                        height: 200,
                      ),
                    ),
                  ],
                )
              : NutrientBarGraph(
                  nutrients: allScannedData,
                  onlyMacro: true,
                ),
        ),
        sHeightSpan,
        _buildFooter(),
      ],
    );
  }

  Widget _buildRichText(String text) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: text,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontFamily: kFontFamily,
              fontSize: 18,
            ),
          ),
          const TextSpan(
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
    );
  }

  Widget _buildFooter() {
    if (isLoggedin) {
      if (allScannedData.isNotEmpty) {
        return GestureDetector(
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
        );
      } else {
        return GestureDetector(
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
        );
      }
    } else {
      return GestureDetector(
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
      );
    }
  }
}
