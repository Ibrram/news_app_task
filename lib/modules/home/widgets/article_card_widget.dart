import 'package:flutter/material.dart';
import 'package:news_app_task/core/constants/app_assets.dart';
import 'package:news_app_task/core/models/article_model.dart';
import 'package:news_app_task/core/theme_manager/colors_palette.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../l10n/app_localizations.dart';

class ArticleCardWidget extends StatelessWidget {
  final ArticleData artcile;
  const ArticleCardWidget({super.key, required this.artcile});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    AppLocalizations lang = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) {
            return Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorsPalette.primaryBlackColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: (artcile.urlToImage != "")
                        ? Image.network(artcile.urlToImage, fit: BoxFit.cover)
                        : Image.asset(
                            AppAssets.noImagePlaceholder,
                            fit: BoxFit.contain,
                            height: 220,
                          ),
                  ),
                  Text(
                    artcile.description,
                    style: theme.textTheme.displayMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => launchArtcileUrl(artcile.url),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        lang.view_article_button,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(color: ColorsPalette.primaryBlackColor),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: (artcile.urlToImage != "")
                  ? Image.network(artcile.urlToImage, fit: BoxFit.cover)
                  : Image.asset(
                      AppAssets.noImagePlaceholder,
                      fit: BoxFit.contain,
                      height: 220,
                    ),
            ),
            Text(
              artcile.title,
              style: theme.textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${lang.article_author}: ${shortAuthorName(artcile.author)}',
                  style: theme.textTheme.displaySmall,
                ),
                Text(
                  publishTimeConvert(artcile.publishedAt, lang),
                  style: theme.textTheme.displaySmall,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String shortAuthorName(String name) {
    List<String> split = name.split(" ");
    if (split.length >= 2) {
      return "${split[0]} ${split[1]}...";
    } else if (split.length == 1) {
      return split[0];
    }

    return "";
  }

  String publishTimeConvert(String dateIso, AppLocalizations lang) {
    final date = DateTime.parse(dateIso);
    final now = DateTime.now().toUtc();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} ${lang.publish_time_seconds}';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} ${lang.publish_time_minutes}';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} ${lang.publish_time_hours}';
    } else if (difference.inDays < 30) {
      return '${difference.inDays} ${lang.publish_time_days}';
    } else if (difference.inDays < 365) {
      return '${(difference.inDays / 30).floor()} ${lang.publish_time_months}';
    } else {
      return '${(difference.inDays / 365).floor()} ${lang.publish_time_years}';
    }
  }

  Future<void> launchArtcileUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}
