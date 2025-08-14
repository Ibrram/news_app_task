import 'package:flutter/material.dart';
import 'package:news_app_task/core/theme_manager/colors_palette.dart';

class CategoryCardWidget extends StatelessWidget {
  final Map<String, dynamic> category;
  final Alignment align;
  final Function()? onTap;
  const CategoryCardWidget({
    super.key,
    required this.category,
    required this.align,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Container(
        height: 199,
        alignment: align,
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(category['banner']),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            color: ColorsPalette.scaffoldBackground.withAlpha(255 * 50 ~/ 100),
            borderRadius: BorderRadius.circular(84),
          ),
          child: Directionality(
            textDirection: align == Alignment.bottomRight
                ? TextDirection.ltr
                : TextDirection.rtl,
            child: InkWell(
              onTap: onTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 9,
                      horizontal: 16,
                    ),
                    child: Text('View All', style: theme.textTheme.bodyLarge),
                  ),
                  AspectRatio(
                    aspectRatio: 1,
                    child: CircleAvatar(
                      foregroundColor: ColorsPalette.primaryBlackColor,
                      backgroundColor: ColorsPalette.scaffoldBackground,
                      child: const Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
