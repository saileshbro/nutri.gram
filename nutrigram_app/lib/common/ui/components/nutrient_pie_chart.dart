import 'package:flutter/material.dart';
import 'package:nutrigram_app/datamodels/nutrient.dart';
import 'package:pie_chart/pie_chart.dart';

class NutrientPieChart extends StatelessWidget {
  final List<Nutrient> nutrients;
  final bool showLegend;
  final double? radius;

  const NutrientPieChart({
    Key? key,
    required this.nutrients,
    this.showLegend = false,
    this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nutrientData = _prepareNutrientData(nutrients);
    final colors = nutrientData.values.map((e) => e.color).toList();
    final dataMap =
        nutrientData.map((key, value) => MapEntry(key, value.value));

    final chartRadius = radius ?? MediaQuery.of(context).size.width * 0.5;

    return PieChart(
      dataMap: dataMap,
      colorList: colors,
      chartRadius: chartRadius,
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
            .labelLarge
            ?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  /// Prepares a map of nutrient types with their respective values and colors.
  Map<String, _NutrientData> _prepareNutrientData(List<Nutrient> nutrients) {
    final Map<String, _NutrientData> data = {};
    final List<Nutrient> nutrientsCopy = [...nutrients]..shuffle();

    for (final nutrient in nutrientsCopy) {
      if (nutrient.type.toLowerCase() != 'total' &&
          nutrient.unit.toLowerCase() != 'kcal') {
        final double adjustedValue = nutrient.unit.toLowerCase() == 'g'
            ? nutrient.value * 1000.0 // Convert grams to milligrams
            : nutrient.value * 7.0; // Custom multiplier for non-gram units
        data[nutrient.type] =
            _NutrientData(value: adjustedValue, color: nutrient.color);
      }
    }

    return data;
  }
}

/// Data model for nutrient value and color pairing.
class _NutrientData {
  final double value;
  final Color color;

  const _NutrientData({required this.value, required this.color});
}
