import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/components/custom_nav_bar.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';

class AdviceView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        llHeightSpan,
        Padding(
          padding: lXPadding,
          child: Column(
            children: const [
              CustomNavBar(
                navBarItemTitle: "Advice",
                blackString: "Go through your ",
                blueString: "saved scans",
              ),
            ],
          ),
        ),
      ],
    );
  }
}
