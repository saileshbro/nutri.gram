import 'package:flutter/material.dart';
import 'package:nutrigram_app/app/locator.dart';
import 'package:nutrigram_app/common/ui/components/custom_nav_bar.dart';
import 'package:nutrigram_app/common/ui/components/d_text_field.dart';
import 'package:nutrigram_app/common/ui/components/nutrition_search_card.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/ui/views/search/search_viewmodel.dart';
import 'package:stacked/stacked.dart';

class SearchView extends StatelessWidget {
  const SearchView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder.reactive(
      builder: (BuildContext context, SearchViewModel model, Widget? child) {
        return Padding(
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
                onEditingComplete: () => _handleSearch(model),
                onChanged: (val) => model.query = val,
                validator: model.validateQuery,
                prefixIcon: const Icon(Icons.search),
                enabled: !model.isBusy,
                hintText: "100g Butter...",
              ),
              mHeightSpan,
              _buildSearchUi(context, model),
            ],
          ),
        );
      },
      disposeViewModel: false,
      viewModelBuilder: () => locator<SearchViewModel>(),
    );
  }

  void _handleSearch(SearchViewModel model) {
    try {
      model.getSearchData();
    } catch (e) {
      // Optionally log or show an error to the user
      debugPrint("Error during search: $e");
    }
  }

  Widget _buildSearchUi(BuildContext context, SearchViewModel model) {
    final double height = MediaQuery.of(context).size.height * 0.4;

    if (model.isBusy) {
      return SizedBox(
        height: height,
        child: const Center(child: CircularProgressIndicator()),
      );
    }

    if (!model.hasSearchResult) {
      return SizedBox(
        height: height,
        child: const Center(
          child: Text(
            "No results found.\nTry searching for '10g Butter' or '1 slice cheese'.",
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    return NutrientSearchCard(
      imageUrl: model.imageUrl,
      name: model.name,
      onPressed: model.onFoodTap,
    );
  }
}
