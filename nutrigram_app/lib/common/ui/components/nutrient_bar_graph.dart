import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/datamodels/nutrient.dart';

class NutrientBarGraph extends StatelessWidget {
  final List<Nutrient> nutrients;
  final bool onlyMacro;

  const NutrientBarGraph({
    Key? key,
    required this.nutrients,
    this.onlyMacro = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _buildChart(
            context,
            "Macronutrients (g)",
            _filterMacroNutrients,
            kPrimaryColor,
          ),
        ),
        if (!onlyMacro) ...[
          mHeightSpan,
          Expanded(
            child: _buildChart(
              context,
              "Micronutrients (mg)",
              _filterMicroNutrients,
              Colors.pinkAccent,
            ),
          ),
          mHeightSpan,
        ],
      ],
    );
  }

  // Helper method to build chart containers
  Widget _buildChart(
    BuildContext context,
    String title,
    List<Nutrient> Function() filterFn,
    Color fillColor,
  ) {
    final data = filterFn();

    return Container(
      padding: mPadding,
      decoration: BoxDecoration(
        color: homeCardColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: homeCardColor, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .labelLarge
                ?.copyWith(fontWeight: FontWeight.bold),
          ),
          xsHeightSpan,
          Expanded(
            child: BarChart(
              BarChartData(
                barGroups: _generateBarGroups(data, fillColor),
                titlesData: _buildTitlesData(),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  drawVerticalLine: false,
                  horizontalInterval: 10,
                  getDrawingHorizontalLine: (_) => FlLine(
                    color: Colors.grey.shade300,
                    strokeWidth: 1,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Generate bar groups for chart
  List<BarChartGroupData> _generateBarGroups(
    List<Nutrient> data,
    Color fillColor,
  ) {
    return List.generate(data.length, (index) {
      final nutrient = data[index];
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: nutrient.value.toDouble(),
            color: fillColor,
            width: 12,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }

  // Build axis titles
  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          interval: 10,
          getTitlesWidget: (value, _) => Text(
            value.toInt().toString(),
            style: const TextStyle(
              fontSize: 10,
              color: Colors.black,
            ),
          ),
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            final index = value.toInt();
            if (index >= nutrients.length) return const SizedBox.shrink();
            return Text(
              nutrients[index].type.replaceAll(" ", "\n"),
              style: const TextStyle(
                fontSize: 9,
                color: Colors.black,
              ),
            );
          },
        ),
      ),
    );
  }

  // Filter macronutrients
  List<Nutrient> _filterMacroNutrients() {
    return nutrients.where((element) {
      return element.type.toLowerCase() != 'total' &&
          element.unit.toLowerCase() != 'kcal' &&
          element.unit.toLowerCase() == 'g';
    }).toList();
  }

  // Filter micronutrients
  List<Nutrient> _filterMicroNutrients() {
    return nutrients.where((element) {
      return element.type.toLowerCase() != 'total' &&
          element.unit.toLowerCase() == 'mg';
    }).toList();
  }
}
