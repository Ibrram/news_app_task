import 'package:flutter/material.dart';
import 'package:news_app_task/api/requests.dart';
import 'package:news_app_task/core/models/article_model.dart';
import 'package:news_app_task/core/theme_manager/colors_palette.dart';
import 'package:news_app_task/modules/home/widgets/article_card_widget.dart';

import '../../l10n/app_localizations.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? query;
  bool isLoading = false;
  bool isNewSearch = false;
  int currentPage = 1;
  bool isLoadMoreButtonClicked = true;
  List<ArticleData> artciles = [];
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    AppLocalizations lang = AppLocalizations.of(context)!;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 16,
            children: [
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    query = value;
                    isNewSearch = true;
                  });
                  if (value.length >= 5) {
                    isLoading = true;
                    getArtciles();
                  }
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.search_rounded,
                    size: 24,
                    color: ColorsPalette.primaryBlackColor,
                  ),
                  contentPadding: const EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: const BorderSide(
                      color: ColorsPalette.primaryBlackColor,
                    ),
                  ),
                ),
                style: theme.textTheme.bodyMedium,
              ),
              if (query == null || query!.length < 5)
                Center(child: Text(lang.search_query_condition))
              else if (isLoading)
                const Center(child: CircularProgressIndicator())
              else if (artciles.isEmpty)
                Center(child: Text(lang.search_query_no_article))
              else
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == artciles.length) {
                        return ElevatedButton(
                          onPressed: () {
                            setState(() {
                              isLoadMoreButtonClicked = true;
                            });
                            isNewSearch = false;
                            currentPage++;
                            getArtciles();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: ContinuousRectangleBorder(
                              side: const BorderSide(
                                color: ColorsPalette.primaryBlackColor,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: isLoadMoreButtonClicked
                                  ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(),
                                    )
                                  : Text(lang.load_more_button),
                            ),
                          ),
                        );
                      }
                      ArticleData artcile = artciles[index];
                      return ArticleCardWidget(artcile: artcile);
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 16),
                    itemCount: artciles.length + 1,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getArtciles() async {
    if (query == null || query!.length < 5) return;
    var fetch = await Requests.getArticles(
      query: query,
      page: currentPage.toString(),
    );
    if (fetch != null && fetch.articles.isNotEmpty) {
      isNewSearch ? artciles = fetch.articles : artciles.addAll(fetch.articles);
    }
    setState(() {
      isLoading = false;
      if (isLoadMoreButtonClicked) isLoadMoreButtonClicked = false;
    });
  }
}
