import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/components/d_progress_bar.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/datamodels/nutrient.dart';
import 'package:nutrigram_app/ui/views/nutrient_info_display/nutrient_info_display_viewmodel.dart';
import 'package:stacked/stacked.dart';

class NutrientInfoDisplayView extends StatelessWidget {
  final List<Nutrient> nutrients;
  final String name;
  final DateTime dateTime;

  const NutrientInfoDisplayView({
    Key key,
    @required this.nutrients,
    this.name = "Package Name",
    this.dateTime,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NutrientInfoDisplayViewModel>.reactive(
      viewModelBuilder: () => NutrientInfoDisplayViewModel(),
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
              padding: lXPadding,
              children: [
                llHeightSpan,
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
    return Column(
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
            title: e.type,
            value: "${e.value.toString()} ${e.unit}",
          );
        }
        if (e.unit.toLowerCase() == 'kcal') {
          return DProgressBar(
            percent: 100,
            title: e.type,
            value: "${e.value.toString()} ${e.unit}",
          );
        } else {
          return DProgressBar(
            percent: ratio < 0.01 ? (ratio * 100 * 15) : (ratio * 100),
            title: e.type,
            value: "${e.value.toString()} ${e.unit}",
          );
        }
      }).toList(),
    );
  }

  bool compareNutrient(Nutrient a, Nutrient b) {
    if (a.type.toLowerCase() == b.type.toLowerCase()) {
      return a.value > b.value;
    }
    if (a.type.toLowerCase() == "g" && b.type.toLowerCase() == 'mg') {
      return a.value * 1000 > b.value;
    }
    if (a.type.toLowerCase() == "mg" && b.type.toLowerCase() == 'g') {
      return a.value > b.value * 1000;
    }
    return false;
  }
}
// add all except total weight and kcal
// and then get percentage based on the total added
