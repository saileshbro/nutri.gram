import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

import 'package:nutrigram_app/datamodels/nutrient.dart';

class NutrientPieChart extends StatelessWidget {
  final List<Nutrient> nutrients;
  final bool showLegend;
  final double radius;

  const NutrientPieChart({
    Key key,
    this.nutrients,
    this.showLegend = false,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, double> data = {};
    final List<Color> _colors = [];
    final List<Nutrient> nutrientsCopy = [...nutrients];
    nutrientsCopy.shuffle();
    // ignore: avoid_function_literals_in_foreach_calls
    nutrientsCopy.forEach((e) {
      if (e.type.toLowerCase() != 'total' && e.unit.toLowerCase() != 'kcal') {
        _colors.add(e.color);
        if (e.unit.toLowerCase() == "g") {
          data[e.type] = e.value.toDouble() * 1000.0;
        } else {
          data[e.type] = e.value.toDouble() * 7.0;
        }
      }
    });
    return PieChart(
      dataMap: data,
      colorList: _colors,
      chartRadius: radius ?? MediaQuery.of(context).size.width * 0.5,
      animationDuration: Duration(milliseconds: showLegend ? 1000 : 600),
      chartLegendSpacing: 42.0,
      chartValuesOptions: const ChartValuesOptions(
        showChartValues: false,
      ),
      legendOptions: LegendOptions(
        showLegends: showLegend,
        legendPosition: LegendPosition.bottom,
        showLegendsInRow: true,
        legendTextStyle: Theme.of(context)
            .textTheme
            .button
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }
}
