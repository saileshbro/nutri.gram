import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/components/custom_nav_bar.dart';
import 'package:nutrigram_app/common/ui/components/icon_button.dart';
import 'package:nutrigram_app/common/ui/misc/scan_overlay_shape.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';

class ScanView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // camera in bottom level
        Container(color: Colors.red[100]),
        Container(
          decoration: ShapeDecoration(
            shape: ScanOverlayShape(
              overlayColor: Colors.white.withOpacity(.85),
              cutOutSize: MediaQuery.of(context).size.width * .90,
            ),
          ),
        ),
        Column(
          children: [
            llHeightSpan,
            Expanded(
              child: Padding(
                padding: lXPadding,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    CustomNavBar(
                      navBarItemTitle: "Scan",
                      blackString: "Scan to know about ",
                      blueString: "nutrition and calories",
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 16,
          right: 24,
          left: 52,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: CustomIconButton(
                  gradientColor: kPrimaryColor,
                  color: kPrimaryColor,
                  icon: Icons.camera,
                  onPressed: () {},
                ),
              ),
              const Spacer(),
              Flexible(
                child: CustomIconButton(
                  gradientColor: kPrimaryColor,
                  color: kPrimaryColor,
                  icon: Icons.insert_photo,
                  onPressed: () {},
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
