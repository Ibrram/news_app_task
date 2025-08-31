import 'package:flutter/material.dart';
import 'package:news_app_task/core/providers/app_provider.dart';
import 'package:news_app_task/core/theme_manager/colors_palette.dart';
import 'package:provider/provider.dart';

import '../../../l10n/app_localizations.dart';
import '../../../widgets/drop_down_menu_widget.dart';

class DrawerWidget extends StatefulWidget {
  final Function()? goToHomeTap;
  const DrawerWidget({super.key, required this.goToHomeTap});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    AppLocalizations lang = AppLocalizations.of(context)!;
    AppProvider provider = Provider.of<AppProvider>(context, listen: false);
    // String selectedLang = provider.locale.languageCode;
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
              onTap: widget.goToHomeTap,
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      Icon(
                        Icons.imagesearch_roller_outlined,
                        size: 24,
                        color: ColorsPalette.scaffoldBackground,
                      ),
                      Text(
                        lang.drawer_change_theme,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: ColorsPalette.scaffoldBackground,
                        ),
                      ),
                    ],
                  ),
                  DropDownMenuWidget(
                    items: [
                      DropdownMenuItem(
                        value: 'light',
                        child: Text(lang.theme_mode_light),
                      ),
                      DropdownMenuItem(
                        value: 'dark',
                        child: Text(lang.theme_mode_dark),
                      ),
                    ],
                    onChanged: (value) {},
                    selected: 'light',
                  ),
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      Icon(
                        Icons.language_outlined,
                        size: 24,
                        color: ColorsPalette.scaffoldBackground,
                      ),
                      Text(
                        lang.drawer_change_lang,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: ColorsPalette.scaffoldBackground,
                        ),
                      ),
                    ],
                  ),
                  DropDownMenuWidget(
                    items: [
                      const DropdownMenuItem(
                        value: 'en',
                        child: Text('English'),
                      ),
                      const DropdownMenuItem(
                        value: 'ar',
                        child: Text('العربية'),
                      ),
                    ],
                    onChanged: (value) {
                      if (value == null) return;
                      provider.changeLang(value);
                    },
                    selected: provider.locale.languageCode,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
