import 'package:flutter/material.dart';
import 'package:news_app_task/core/theme_manager/colors_palette.dart';

import '../../../l10n/app_localizations.dart';

class DrawerWidget extends StatelessWidget {
  final Function()? goToHomeTap;
  const DrawerWidget({super.key, required this.goToHomeTap});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    AppLocalizations lang = AppLocalizations.of(context)!;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          spacing: 16,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(65),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ColorsPalette.scaffoldBackground,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Text(
                lang.drawer_app_name,
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),

            ListTile(
              title: Text(
                lang.drawer_home_button,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: ColorsPalette.scaffoldBackground,
                ),
              ),
              leading: Icon(
                Icons.home_outlined,
                size: 24,
                color: ColorsPalette.scaffoldBackground,
              ),
              onTap: goToHomeTap,
            ),
          ],
        ),
      ),
    );
  }
}
