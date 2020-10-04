import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/components/custom_tab_bar.dart';
import 'package:nutrigram_app/common/ui/components/nutrient_bar_graph.dart';
import 'package:nutrigram_app/common/ui/components/nutrient_pie_chart.dart';
import 'package:stacked/stacked.dart';

import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/extensions/string.dart';
import 'package:nutrigram_app/common/ui/components/custom_nav_bar.dart';
import 'package:nutrigram_app/common/ui/components/d_progress_bar.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/datamodels/nutrient.dart';
import 'package:nutrigram_app/ui/views/view_more_graph/view_more_graph_viewmodel.dart';

class ViewMoreGraphView extends StatelessWidget {
  final List<Nutrient> nutrients;
  final String name;
  final String searchTerm;
  final String date;

  const ViewMoreGraphView({
    Key key,
    @required this.nutrients,
    this.name,
    this.date,
    this.searchTerm,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewMoreGraphViewModel>.reactive(
      viewModelBuilder: () => locator<ViewMoreGraphViewModel>(),
      disposeViewModel: false,
      builder: (
        BuildContext context,
        ViewMoreGraphViewModel model,
        Widget child,
      ) {
        return Scaffold(
          bottomNavigationBar: Container(
            decoration:
                BoxDecoration(boxShadow: getBoxShadow(context, kPrimaryColor)),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 0.0,
              backgroundColor: Theme.of(context).bottomAppBarColor,
              currentIndex: model.currentIndex,
              onTap: model.setIndex,
              selectedItemColor: kPrimaryColor,
              unselectedItemColor: kDisabledLightThemeColor,
              unselectedLabelStyle:
                  const TextStyle(color: kDisabledLightThemeColor),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.assignment,
                  ),
                  label: "Nutrients",
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.poll,
                  ),
                  label: "Graph",
                ),
              ],
            ),
          ),
          body: PageTransitionSwitcher(
            reverse: model.reverse,
            transitionBuilder: (
              Widget child,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
            ) {
              return SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                child: child,
              );
            },
            child: getViewForIndex(context, model),
          ),
        );
      },
    );
  }

  Widget getViewForIndex(BuildContext context, ViewMoreGraphViewModel model) {
    switch (model.currentIndex) {
      case 0:
        return buildNutrientsDisplay(context);
      case 1:
        return buildGraphsDisplay(context, model);
      default:
        return buildNutrientsDisplay(context);
    }
  }

  Widget buildGraphsDisplay(
      BuildContext context, ViewMoreGraphViewModel model) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        llHeightSpan,
        const CustomNavBar(
          navBarItemTitle: "Graph",
          blackString: "Visualize",
          blueString: " your scan.",
          backNeeded: true,
        ),
        mHeightSpan,
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: lXPadding,
                child: CustomTabBar(
                  items: const ["Pie chart", "Bar graph"],
                  defaultIndex: model.graphTabIndex,
                  onChanged: model.onGraphIndexChanged,
                ),
              ),
              if (model.graphTabIndex == 0) ...[
                lHeightSpan,
                Expanded(
                  child: ListView(
                    padding: lXPadding,
                    children: [
                      NutrientPieChart(
                        nutrients: nutrients,
                        showLegend: true,
                        radius: MediaQuery.of(context).size.width * 0.8,
                      ),
                    ],
                  ),
                )
              ] else ...[
                lHeightSpan,
                Expanded(
                  child: Padding(
                    padding: lXPadding,
                    child: NutrientBarGraph(
                      nutrients: nutrients,
                    ),
                  ),
                )
              ]
            ],
          ),
        )
      ],
    );
  }

  Widget buildNutrientsDisplay(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          llHeightSpan,
          const CustomNavBar(
            navBarItemTitle: "Nutrients",
            blackString: "Nutrient details of",
            blueString: " your recent scan.",
            backNeeded: true,
          ),
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
                          style: Theme.of(context).textTheme.button.copyWith(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                        xsHeightSpan,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                ]),
          ),
          lHeightSpan,
          getProgressBars(),
        ],
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
