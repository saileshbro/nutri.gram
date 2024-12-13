import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:nutrigram_app/common/ui/functions/show_custom_bottomsheet.dart';
import 'package:nutrigram_app/common/ui/ui_helpers.dart';
import 'package:nutrigram_app/constants/constants.dart';
import 'package:nutrigram_app/datamodels/home/health_tip_response_model.dart';

class HealthTipsCard extends StatelessWidget {
  final HealthTip healthTip;
  final VoidCallback? onBottomSheetClosed;
  final VoidCallback? onPressed;

  const HealthTipsCard({
    Key? key,
    required this.healthTip,
    this.onBottomSheetClosed,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onPressed != null) onPressed!();
        showCustomBottomSheet(
          context,
          child: _HealthTipsExpanded(healthTip: healthTip),
          onDismiss: onBottomSheetClosed,
        );
      },
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
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0)
                  .add(const EdgeInsets.only(top: 2)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: healthTip.imageUrl,
                  height: 160,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) =>
                      const Icon(Icons.error, color: Colors.red),
                ),
              ),
            ),
            sHeightSpan,
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    healthTip.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const Text(
                    "Read more",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: kPrimaryColor,
                    ),
                  ),
                ],
              ),
            ),
            sHeightSpan,
          ],
        ),
      ),
    );
  }
}

class _HealthTipsExpanded extends StatelessWidget {
  final HealthTip healthTip;

  const _HealthTipsExpanded({Key? key, required this.healthTip})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: mXPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            healthTip.title,
            style: Theme.of(context).textTheme.titleMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          mHeightSpan,
          Container(
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(23, 138, 232, 0.27),
                  offset: Offset(0, 4),
                  blurRadius: 10,
                ),
              ],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: kPrimaryColor.withOpacity(0.3),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: CachedNetworkImage(
                imageUrl: healthTip.imageUrl,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Icon(Icons.error, color: Colors.red),
              ),
            ),
          ),
          lHeightSpan,
          Text(
            healthTip.description,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
