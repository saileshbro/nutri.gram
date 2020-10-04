import 'package:flutter/material.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/ui/components/d_progress_bar.dart';
import 'package:nutrigram_app/common/ui/components/custom_icon_button.dart';
import 'package:nutrigram_app/common/ui/components/d_text_field.dart';
import 'package:nutrigram_app/common/ui/components/nutrient_pie_chart.dart';
import 'package:nutrigram_app/common/ui/functions/show_custom_bottomsheet.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/datamodels/nutrient.dart';
import 'package:nutrigram_app/datamodels/scan/scan_request_model.dart';
import 'package:nutrigram_app/ui/views/nutrient_info_display/nutrient_info_display_viewmodel.dart';
import 'package:stacked/stacked.dart';
import 'package:nutrigram_app/common/extensions/string.dart';

class NutrientInfoDisplayView extends StatelessWidget {
  final List<Nutrient> nutrients;
  final String name;
  final String searchTerm;
  final String date;
  final bool showSaveButton;

  const NutrientInfoDisplayView({
    Key key,
    @required this.nutrients,
    this.name = "Package Name",
    this.date,
    this.searchTerm,
    @required this.showSaveButton,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NutrientInfoDisplayViewModel>.reactive(
      viewModelBuilder: () => locator<NutrientInfoDisplayViewModel>(),
      disposeViewModel: false,
      builder: (
        BuildContext context,
        NutrientInfoDisplayViewModel model,
        Widget child,
      ) {
        return Scaffold(
          body: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                child,
                mHeightSpan,
                Padding(
                  padding: lXPadding,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () => model.isLoggedIn
                                    ? showCustomBottomSheet(
                                        context,
                                        child: ChangeScanNameForm(
                                          model: model,
                                          value: model.isNameChanged
                                              ? model.newName
                                              : "",
                                        ),
                                      )
                                    : null,
                                child: Text(
                                  (model.isNameChanged ? model.newName : name)
                                      .allWordsCapitilize(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4
                                      .copyWith(
                                        decoration: !model.isNameChanged &&
                                                model.isLoggedIn
                                            ? TextDecoration.underline
                                            : TextDecoration.none,
                                        decorationColor: kPrimaryColor,
                                      ),
                                ),
                              ),
                              xsHeightSpan,
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    date,
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                  Text(
                                    searchTerm ?? "",
                                    style: Theme.of(context).textTheme.caption,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        if (showSaveButton && model.isLoggedIn) ...[
                          mWidthSpan,
                          CustomIconButton(
                            color: kPrimaryColor,
                            gradientColor: Colors.blue,
                            icon: Icons.save,
                            onPressed: () => model.saveScanData(
                              ScanRequestModel(
                                foodName:
                                    (model.isNameChanged ? model.newName : name)
                                        .allWordsCapitilize(),
                                data: nutrients,
                                searchTerm: searchTerm,
                              ),
                            ),
                            isBusy: model.isBusy,
                          )
                        ]
                      ]),
                ),
                lHeightSpan,
                getProgressBars(),
              ],
            ),
          ),
        );
      },
      staticChild: Container(
        padding: sYPadding.add(const EdgeInsets.only(top: 8)),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: homeCardColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppBar(
              backgroundColor: homeCardColor,
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
            ),
            NutrientPieChart(nutrients: nutrients),
          ],
        ),
      ),
    );
  }

  Widget getProgressBars() {
    // in mg
    num totalWeight = 0;
    for (int i = 0; i < nutrients.length; i++) {
      if (nutrients[i].type.toLowerCase() != 'total' &&
          nutrients[i].unit.toLowerCase() != 'kcal') {
        totalWeight += nutrients[i].unit.toLowerCase() == "g"
            ? nutrients[i].value * 1000
            : nutrients[i].value;
      }
    }
    return Padding(
      padding: lXPadding,
      child: Column(
        children: nutrients.map((e) {
          if (e.value == 0) {
            return const SizedBox.shrink();
          }
          final num ratio =
              (e.unit.toLowerCase() == "g" ? e.value * 1000 : e.value) /
                  totalWeight;
          if (e.type.toLowerCase() == 'total') {
            return Column(
              children: [
                DProgressBar(
                  percent: 100,
                  color: e.color,
                  title: e.type,
                  value: "${e.value.toString()} ${e.unit}",
                ),
                xsHeightSpan,
              ],
            );
          }
          if (e.unit.toLowerCase() == 'kcal') {
            return Column(
              children: [
                DProgressBar(
                  percent: 100,
                  title: e.type,
                  color: e.color,
                  value: "${e.value.toString()} ${e.unit}",
                ),
                xsHeightSpan
              ],
            );
          } else {
            return Column(
              children: [
                DProgressBar(
                  percent: (ratio * 100).toDouble(),
                  title: e.type,
                  color: e.color,
                  value: "${e.value.toString()} ${e.unit}",
                ),
                xsHeightSpan
              ],
            );
          }
        }).toList(),
      ),
    );
  }
}

class ChangeScanNameForm extends StatelessWidget {
  final NutrientInfoDisplayViewModel model;
  final String value;
  const ChangeScanNameForm({
    Key key,
    this.model,
    this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: sXPagePadding.add(
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)),
      child: Column(
        children: [
          Text(
            "Change product name",
            style: Theme.of(context).textTheme.button,
          ),
          mHeightSpan,
          DTextField(
            hintText: "Product Name",
            autoFocus: true,
            controller: TextEditingController(text: value),
            label: "Product Name",
            onChanged: (val) {
              if (val.isNotEmpty) {
                model.isNameChanged = true;
                model.newName = val;
              } else {
                model.isNameChanged = false;
              }
              model.notifyListeners();
            },
          ),
        ],
      ),
    );
  }
}
