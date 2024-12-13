import 'package:flutter/material.dart';
import 'package:nutrigram_app/constants/constants.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> items;
  final int defaultIndex;
  final ValueChanged<int>? onChanged;

  const CustomTabBar({
    required this.items,
    this.defaultIndex = 0,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.22),
        borderRadius: BorderRadius.circular(42),
      ),
      child: DefaultTabController(
        length: items.length,
        initialIndex: defaultIndex,
        child: TabBar(
          onTap: onChanged,
          indicatorSize: TabBarIndicatorSize.tab,
          indicator: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(42),
          ),
          unselectedLabelColor: Colors.black,
          labelStyle: Theme.of(context)
              .textTheme
              .labelLarge
              ?.copyWith(fontWeight: FontWeight.bold),
          tabs: items.map((item) => Tab(child: Text(item))).toList(),
        ),
      ),
    );
  }
}
