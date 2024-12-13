import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/extensions/string.dart';
import 'package:nutrigram_app/common/ui/components/custom_nav_bar.dart';
import 'package:nutrigram_app/common/ui/components/custom_tab_bar.dart';
import 'package:nutrigram_app/common/ui/components/d_progress_bar.dart';
import 'package:nutrigram_app/common/ui/components/nutrient_bar_graph.dart';
import 'package:nutrigram_app/common/ui/components/nutrient_pie_chart.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/datamodels/nutrient.dart';
import 'package:nutrigram_app/ui/views/view_more_graph/view_more_graph_viewmodel.dart';
import 'package:stacked/stacked.dart';

class ViewMoreGraphView extends StatelessWidget {
  final List<Nutrient> nutrients;
  final String name;
  final String searchTerm;
  final String date;

  const ViewMoreGraphView({
    Key? key,
    required this.nutrients,
    this.name = '',
    this.searchTerm = '',
    this.date = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ViewMoreGraphViewModel>.reactive(
      viewModelBuilder: () => locator<ViewMoreGraphViewModel>(),
      disposeViewModel: false,
      builder: (context, model, _) {
        return Scaffold(
          bottomNavigationBar: _buildBottomNavigationBar(context, model),
          body: PageTransitionSwitcher(
            reverse: model.reverse,
            transitionBuilder: (child, animation, secondaryAnimation) {
              return SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                child: child,
              );
            },
            child: _getViewForIndex(context, model),
          ),
        );
      },
    );
  }

  Widget _buildBottomNavigationBar(
    BuildContext context,
    ViewMoreGraphViewModel model,
  ) {
    return Container(
      decoration:
          BoxDecoration(boxShadow: getBoxShadow(context, kPrimaryColor)),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 0.0,
        backgroundColor: Theme.of(context).bottomAppBarTheme.color,
        currentIndex: model.currentIndex,
        onTap: model.setIndex,
        selectedItemColor: kPrimaryColor,
        unselectedItemColor: kDisabledLightThemeColor,
        unselectedLabelStyle: const TextStyle(color: kDisabledLightThemeColor),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: "Nutrients",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.poll),
            label: "Graph",
          ),
        ],
      ),
    );
  }

  Widget _getViewForIndex(BuildContext context, ViewMoreGraphViewModel model) {
    return model.currentIndex == 0
        ? _buildNutrientsDisplay(context)
        : _buildGraphsDisplay(context, model);
  }

  Widget _buildGraphsDisplay(
      BuildContext context, ViewMoreGraphViewModel model) {
    return Column(
      children: [
        lHeightSpan,
        const CustomNavBar(
          navBarItemTitle: "Graph",
          blackString: "Visualize",
          blueString: " your scan.",
          backNeeded: true,
        ),
        mHeightSpan,
        Expanded(
          child: Column(
            children: [
              Padding(
                padding: lXPadding,
                child: CustomTabBar(
                  items: const ["Pie chart", "Bar graph"],
                  defaultIndex: model.graphTabIndex,
                  onChanged: model.onGraphIndexChanged,
                ),
              ),
              lHeightSpan,
              Expanded(
                child: model.graphTabIndex == 0
                    ? NutrientPieChart(
                        nutrients: nutrients,
                        showLegend: true,
                        radius: MediaQuery.of(context).size.width * 0.8,
                      )
                    : NutrientBarGraph(nutrients: nutrients),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNutrientsDisplay(BuildContext context) {
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
          _buildNutrientInfo(context),
          lHeightSpan,
          _buildProgressBars(),
        ],
      ),
    );
  }

  Widget _buildNutrientInfo(BuildContext context) {
    return Padding(
      padding: lXPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name.allWordsCapitilize(),
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
          ),
          xxsHeightSpan,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(date, style: Theme.of(context).textTheme.bodySmall),
              Text(searchTerm, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBars() {
    final totalWeight = nutrients.fold<double>(0, (sum, nutrient) {
      if (nutrient.type.toLowerCase() != 'total' &&
          nutrient.unit.toLowerCase() != 'kcal') {
        return sum +
            (nutrient.unit.toLowerCase() == "g"
                ? nutrient.value * 1000
                : nutrient.value);
      }
      return sum;
    });

    return Padding(
      padding: lXPadding,
      child: Column(
        children: nutrients.map((e) {
          if (e.value == 0) return const SizedBox.shrink();

          final ratio =
              (e.unit.toLowerCase() == "g" ? e.value * 1000 : e.value) /
                  totalWeight;
          final percent = (e.type.toLowerCase() == 'total' ||
                  e.unit.toLowerCase() == 'kcal')
              ? 100
              : (ratio * 100);

          return Column(
            children: [
              DProgressBar(
                percent: percent,
                title: e.type,
                color: e.color,
                value: "${e.value} ${e.unit}",
              ),
              xsHeightSpan,
            ],
          );
        }).toList(),
      ),
    );
  }
}
