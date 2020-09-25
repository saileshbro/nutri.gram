import 'package:flutter/material.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/ui/components/d_progress_bar.dart';
import 'package:nutrigram_app/common/ui/components/icon_button.dart';
import 'package:nutrigram_app/common/ui/components/nutrient_pie_chart.dart';
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
              children: [
                Container(
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
                    )),
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
                              Text(
                                name.allWordsCapitilize(),
                                style: Theme.of(context).textTheme.headline4,
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
                                foodName: name,
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
            return DProgressBar(
              percent: 100,
              color: e.color,
              title: e.type,
              value: "${e.value.toString()} ${e.unit}",
            );
          }
          if (e.unit.toLowerCase() == 'kcal') {
            return DProgressBar(
              percent: 100,
              title: e.type,
              color: e.color,
              value: "${e.value.toString()} ${e.unit}",
            );
          } else {
            return DProgressBar(
              percent: ratio * 100,
              title: e.type,
              color: e.color,
              value: "${e.value.toString()} ${e.unit}",
            );
          }
        }).toList(),
      ),
    );
  }
}
