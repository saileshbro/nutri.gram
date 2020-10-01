import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/components/history_card.dart';
import 'package:stacked/stacked.dart';

import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/ui/components/custom_nav_bar.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/ui/views/history/history_viewmodel.dart';

class HistoryView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HistoryViewModel>.reactive(
      viewModelBuilder: () => locator<HistoryViewModel>(),
      onModelReady: (model) => model.init(),
      disposeViewModel: false,
      fireOnModelReadyOnce: true,
      builder: (
        BuildContext context,
        HistoryViewModel model,
        Widget child,
      ) {
        return SizedBox(
          height:
              MediaQuery.of(context).size.height - kBottomNavigationBarHeight,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              llHeightSpan,
              const Padding(
                padding: lXPadding,
                child: CustomNavBar(
                  navBarItemTitle: "History",
                  blackString: "Go through your ",
                  blueString: "saved scans",
                ),
              ),
              mHeightSpan,
              getHistoryList(context, model),
            ],
          ),
        );
      },
    );
  }

  Widget getHistoryList(BuildContext context, HistoryViewModel model) {
    if (!model.isLoggedIn) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: const Center(child: Text("Login to see your saved scans here!")),
      );
    }
    if (model.isBusy) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    if (model.historyItems.isEmpty) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: const Center(child: Text("Scan History here!")),
      );
    } else {
      return Expanded(
        child: RefreshIndicator(
          onRefresh: model.refresh,
          child: ListView.separated(
            padding: lXPadding.add(mYPadding),
            itemCount: model.historyItems.length,
            separatorBuilder: (BuildContext context, int index) => mHeightSpan,
            itemBuilder: (BuildContext context, int index) {
              return HistoryCard(
                history: model.historyItems[index],
                onDeletePressed: () =>
                    model.onDeletePressed(model.historyItems[index]),
                onPressed: () =>
                    model.onHistoryCardPressed(model.historyItems[index]),
              );
            },
          ),
        ),
      );
    }
  }
}
