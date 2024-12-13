import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/extensions/string.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';

class NutrientSearchCard extends StatelessWidget {
  final VoidCallback onPressed;
  final String imageUrl;
  final String name;

  const NutrientSearchCard({
    Key? key,
    required this.onPressed,
    required this.imageUrl,
    required this.name,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        margin: sPadding,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color.fromRGBO(23, 138, 232, 0.27),
              offset: Offset(0, 4),
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildImage(),
            sHeightSpan,
            _buildContent(context),
            sHeightSpan,
          ],
        ),
      ),
    );
  }

  /// Builds the image section with a placeholder and error handling.
  Widget _buildImage() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0)
          .add(const EdgeInsets.only(top: 2)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(color: kPrimaryColor),
          ),
          errorWidget: (context, url, error) => const Icon(
            Icons.broken_image,
            color: Colors.grey,
            size: 50,
          ),
        ),
      ),
    );
  }

  /// Builds the textual content of the card.
  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            name.allWordsCapitilize(),
            textAlign: TextAlign.start,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
          sHeightSpan,
          const Text(
            "View Details",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
