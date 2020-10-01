import 'package:flutter/material.dart';
import 'package:flutter_better_camera/camera.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/ui/components/custom_nav_bar.dart';
import 'package:nutrigram_app/common/ui/components/custom_icon_button.dart';
import 'package:nutrigram_app/common/ui/misc/scan_overlay_shape.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/ui/views/scan/scan_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ScanView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ScanViewModel>.reactive(
        builder: (BuildContext context, ScanViewModel model, Widget child) =>
            Stack(
              children: [
                if (model.isBusy) Container(color: Colors.red[100]),
                if (!model.isBusy) CameraView(),
                Container(
                  decoration: ShapeDecoration(
                    shape: ScanOverlayShape(
                      overlayColor: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ),
                Column(
                  children: const [
                    llHeightSpan,
                    Expanded(
                      child: Padding(
                        padding: lXPadding,
                        child: CustomNavBar(
                          navBarItemTitle: "Scan",
                          blackString: "Scan to know about ",
                          blueString: "nutrition and calories",
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 16,
                  right: 20,
                  left: 20,
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
                            icon: Icons.camera,
                            onPressed: model.takePicture,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: CustomIconButton(
                            gradientColor: kPrimaryColor,
                            color: kPrimaryColor,
                            icon: Icons.insert_photo,
                            onPressed: model.pickPicture,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
        disposeViewModel: false,
        onModelReady: (model) => model.init(),
        createNewModelOnInsert: true,
        viewModelBuilder: () => locator<ScanViewModel>());
  }
}

class CameraView extends ViewModelWidget<ScanViewModel> {
  @override
  Widget build(BuildContext context, ScanViewModel model) {
    if (model.controller == null) return const SizedBox.shrink();
    return CameraPreview(model.controller);
  }
}
