import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/components/custom_nav_bar.dart';
import 'package:nutrigram_app/common/ui/components/nutrition_search_card.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';

import 'package:nutrigram_app/common/ui/components/d_text_field.dart';
import 'package:nutrigram_app/ui/views/search/search_viewmodel.dart';
import 'package:stacked/stacked.dart';

import 'package:nutrigram_app/app/locator.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (BuildContext context, SearchViewModel model, Widget child) =>
          Padding(
        padding: lXPadding,
        child: Column(
          children: [
            llHeightSpan,
            const CustomNavBar(
              navBarItemTitle: "Nutrition Search",
              blackString: "Get nutritional value ",
              blueString: "for any food items",
            ),
            llHeightSpan,
            DTextField(
              onEditingComplete: model.getSearchData,
              onChanged: (val) => model.query = val,
              validator: model.validateQuery,
              prefixIcon: const Icon(
                Icons.search,
              ),
              enabled: !model.isBusy,
              hintText: "100g Butter...",
            ),
            mHeightSpan,
            getSearchUi(context, model)
          ],
        ),
      ),
      disposeViewModel: false,
      viewModelBuilder: () => locator<SearchViewModel>(),
    );
  }

  Widget getSearchUi(BuildContext context, SearchViewModel model) {
    if (model.isBusy) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    if (!model.hasSearchResult) {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        child: const Center(child: Text("10g Butter\n1 slice cheese")),
      );
    } else {
      return NutrientSearchCard(
        imageUrl: model.imageUrl,
        name: model.name,
        onPressed: model.onFoodTap,
      );
    }
  }
}
