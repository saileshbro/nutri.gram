import 'package:charts_flutter/flutter.dart' as chart;
import 'package:flutter/material.dart';

import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/datamodels/nutrient.dart';

class NutrientBarGraph extends StatelessWidget {
  final List<Nutrient> nutrients;
  final bool onlyMacro;
  const NutrientBarGraph({Key key, this.nutrients, this.onlyMacro = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: _buildGramChart(context)),
        if (!onlyMacro) ...[
          mHeightSpan,
          Expanded(child: _buildMiliGramChart(context)),
          mHeightSpan,
        ]
      ],
    );
  }

  Widget _buildMiliGramChart(BuildContext context) {
    return Container(
      padding: mPadding,
      decoration: BoxDecoration(
          color: homeCardColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: homeCardColor, width: 2)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Micronutrients (mg)",
            style: Theme.of(context).textTheme.button.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          xsHeightSpan,
          Expanded(
            child: chart.BarChart(
              [
                chart.Series<Nutrient, String>(
                  displayName: "Micronutrients",
                  id: "Nutrient mgs Bar Graph",
                  strokeWidthPxFn: (_, __) => 4,
                  colorFn: (_, __) => chart.Color.transparent,
                  fillColorFn: (_, __) =>
                      chart.ColorUtil.fromDartColor(Colors.pinkAccent),
                  measureFn: (Nutrient nutrient, _) => nutrient.value / 100,
                  domainFn: (Nutrient nutrient, _) =>
                      nutrient.type.replaceAll(" ", "\n"),
                  data: nutrients
                      .where((element) =>
                          element.type.toLowerCase() != 'total' &&
                          element.unit.toLowerCase() != 'kcal' &&
                          element.unit.toLowerCase() != 'g')
                      .toList(),
                ),
              ],
              domainAxis: chart.OrdinalAxisSpec(
                showAxisLine: true,
                renderSpec: chart.SmallTickRendererSpec(
                  // Tick and Label styling here.
                  labelStyle: chart.TextStyleSpec(
                      fontSize: 9, // size in Pts.
                      fontWeight: '600',
                      color: chart.ColorUtil.fromDartColor(Colors.black)),
                  // labelRotation: 90,
                  // Change the line colors to match text color.
                  lineStyle: chart.LineStyleSpec(
                    color: chart.ColorUtil.fromDartColor(Colors.black),
                  ),
                  minimumPaddingBetweenLabelsPx: 12,
                ),
              ),
              primaryMeasureAxis: chart.NumericAxisSpec(
                renderSpec: chart.GridlineRendererSpec(
                  // Tick and Label styling here.
                  minimumPaddingBetweenLabelsPx: 12,

                  labelStyle: chart.TextStyleSpec(
                      fontSize: 10, // size in Pts.
                      color: chart.ColorUtil.fromDartColor(Colors.black)),
                  // Change the line colors to match text color.
                  lineStyle: chart.LineStyleSpec(
                    color: chart.ColorUtil.fromDartColor(Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGramChart(BuildContext context) {
    return Container(
      padding: mPadding,
      decoration: BoxDecoration(
          color: homeCardColor.withOpacity(0.5),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: homeCardColor, width: 2)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Macronutrients (g)",
            style: Theme.of(context).textTheme.button.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          xsHeightSpan,
          Expanded(
            child: chart.BarChart(
              [
                chart.Series<Nutrient, String>(
                  id: "Nutrient gs Bar Graph",
                  strokeWidthPxFn: (_, __) => 4,
                  radiusPxFn: (_, __) => 10,
                  measureFn: (Nutrient nutrient, _) {
                    return nutrient.value;
                  },
                  colorFn: (_, __) => chart.Color.transparent,
                  fillColorFn: (_, __) =>
                      chart.ColorUtil.fromDartColor(kPrimaryColor),
                  domainFn: (Nutrient nutrient, _) =>
                      nutrient.type.replaceAll(" ", "\n"),
                  data: nutrients.where((element) {
                    return element.type.toLowerCase() != 'total' &&
                        element.unit.toLowerCase() != 'kcal' &&
                        element.unit.toLowerCase() != 'mg';
                  }).toList(),
                ),
              ],
              domainAxis: chart.OrdinalAxisSpec(
                showAxisLine: true,
                renderSpec: chart.SmallTickRendererSpec(
                  // Tick and Label styling here.
                  labelRotation: 10,
                  labelAnchor: chart.TickLabelAnchor.after,
                  labelStyle: chart.TextStyleSpec(
                      fontSize: 9, // size in Pts.

                      fontWeight: '600',
                      color: chart.ColorUtil.fromDartColor(Colors.black)),
                  // labelRotation: 90,
                  // Change the line colors to match text color.
                  lineStyle: chart.LineStyleSpec(
                    color: chart.ColorUtil.fromDartColor(Colors.black),
                  ),
                ),
              ),
              primaryMeasureAxis: chart.NumericAxisSpec(
                renderSpec: chart.GridlineRendererSpec(
                  // Tick and Label styling here.
                  labelStyle: chart.TextStyleSpec(
                    fontSize: 10, // size in Pts.
                    color: chart.ColorUtil.fromDartColor(Colors.black),
                  ),
                  minimumPaddingBetweenLabelsPx: 12,
                  // Change the line colors to match text color.

                  lineStyle: chart.LineStyleSpec(
                    color: chart.ColorUtil.fromDartColor(Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
