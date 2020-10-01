import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/ui/components/custom_nav_bar.dart';
import 'package:nutrigram_app/common/ui/components/d_raised_button.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/ui/views/profile/change_image/change_image_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ChangeImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ViewModelBuilder<ChangeImageViewModel>.reactive(
        builder: (BuildContext context, ChangeImageViewModel model,
                Widget child) =>
            Scaffold(
              body: Column(
                children: [
                  llHeightSpan,
                  const CustomNavBar(
                    navBarItemTitle: "Change Avatar",
                    blackString: "Pick image to change your ",
                    blueString: "profile picture",
                    backNeeded: true,
                  ),
                  mHeightSpan,
                  Expanded(
                    child: Padding(
                      padding: lXPadding,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Center(
                              child: Material(
                                borderRadius: BorderRadius.circular(10),
                                elevation: 7,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(13),
                                    color: Colors.white,
                                  ),
                                  height: width * 0.65,
                                  width: width * 0.65,
                                  child: model.image == null
                                      ? GestureDetector(
                                          onTap: model.getNewImage,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Image.asset(
                                                photo,
                                                width: 90,
                                              ),
                                              mHeightSpan,
                                              Padding(
                                                padding: sPadding,
                                                child: Text(
                                                  'Select an Image',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText1
                                                      .copyWith(
                                                        color: Colors.black,
                                                        fontSize: 22,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Image.file(
                                          model.image,
                                          fit: BoxFit.cover,
                                        ),
                                ),
                              ),
                            ),
                          ),
                          if (model.hasImage)
                            DRaisedButton(
                              loading: model.isBusy,
                              onPressed: model.updateImage,
                              title: "Update Avatar",
                            )
                        ],
                      ),
                    ),
                  ),
                  lHeightSpan
                ],
              ),
            ),
        viewModelBuilder: () => locator<ChangeImageViewModel>());
  }
}
