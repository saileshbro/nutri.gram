import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/datamodels/nutrient.dart';
import 'package:pie_chart/pie_chart.dart';

class NutrientPieChart extends StatelessWidget {
  final List<Nutrient> nutrients;

  const NutrientPieChart({Key key, this.nutrients}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, double> data = {};
    final List<Color> _colors = [];
    // ignore: avoid_function_literals_in_foreach_calls
    nutrients.forEach((e) {
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
      chartRadius: MediaQuery.of(context).size.width * 0.5,
      animationDuration: const Duration(milliseconds: 600),
      chartLegendSpacing: 42.0,
      chartValuesOptions: const ChartValuesOptions(
        showChartValues: false,
      ),
      legendOptions: const LegendOptions(
        showLegends: false,
      ),
    );
  }
}
