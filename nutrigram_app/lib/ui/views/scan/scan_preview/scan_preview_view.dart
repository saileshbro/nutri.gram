import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/ui/components/custom_icon_button.dart';
import 'package:nutrigram_app/common/ui/misc/edge_detection/image_preview.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/ui/views/scan/scan_preview/scan_preview_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ScanPreviewView extends StatelessWidget {
  final File image;

  const ScanPreviewView({Key key, this.image}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ScanPreviewViewModel>.reactive(
        builder:
            (BuildContext context, ScanPreviewViewModel model, Widget child) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniCenterFloat,
            floatingActionButton: Container(
              height: kBottomNavigationBarHeight + 20,
              color: Colors.white,
              padding: lXPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Flexible(
                    child: SizedBox.shrink(),
                  ),
                  Flexible(
                    child: Center(
                      child: CustomIconButton(
                        gradientColor: kPrimaryColor,
                        color: kPrimaryColor,
                        icon: Icons.check,
                        isBusy: model.isBusy,
                        onPressed: model.getScanResults,
                      ),
                    ),
                  ),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: CustomIconButton(
                        gradientColor: kPrimaryColor,
                        color: kPrimaryColor,
                        icon: Icons.refresh,
                        onPressed: model.retakePicture,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            body: ImagePreview(
              imagePath: image.path,
              edgeDetectionResult: model.edgeDetectionResult,
              showEdges: model.showEdges,
            ),
          );
        },
        disposeViewModel: false,
        onModelReady: (model) => model.init(image),
        viewModelBuilder: () => locator<ScanPreviewViewModel>());
  }
}
