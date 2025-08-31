import 'package:flutter/material.dart';
import 'package:news_app_task/api/requests.dart';
import 'package:news_app_task/core/models/article_model.dart';
import 'package:news_app_task/core/models/source_model.dart';
import 'package:news_app_task/core/providers/app_provider.dart';
import 'package:news_app_task/core/theme_manager/colors_palette.dart';
import 'package:news_app_task/l10n/app_localizations.dart';
import 'package:news_app_task/modules/home/widgets/article_card_widget.dart';
import 'package:provider/provider.dart';

class HomeListNewsWidget extends StatefulWidget {
  final String categoryToApi;

  const HomeListNewsWidget({super.key, required this.categoryToApi});

  @override
  State<HomeListNewsWidget> createState() => _HomeListNewsWidgetState();
}

class _HomeListNewsWidgetState extends State<HomeListNewsWidget> {
  String? selectedSource;
  late Future<SourceModel?> sourcesFuture;

  // for articles pagination
  bool isLoading = true;
  bool isLoadMoreButtonClicked = false;
  int currentPage = 1;
  String? errorMessage;
  List<ArticleData> articles = [];

  @override
  void initState() {
    super.initState();
    sourcesFuture = Requests.getSources(widget.categoryToApi).then((value) {
      if (value != null && value.sources.isNotEmpty) {
        setState(() {
          selectedSource = value.sources.first.id;
        });
        getArticles();
      }
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    AppLocalizations lang = AppLocalizations.of(context)!;
    AppProvider provider = Provider.of<AppProvider>(context);
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
            future: sourcesFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text(lang.news_sources_unexpected_error));
              }
              if (!snapshot.hasData) {
                return Center(child: Text(lang.news_no_sources));
              }

              final SourceModel source = snapshot.data!;
              return DefaultTabController(
                length: source.sources.length,
                child: TabBar(
                  isScrollable: true,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabAlignment: TabAlignment.start,
                  indicatorWeight: 2,
                  indicatorColor: ColorsPalette.primaryBlackColor,
                  indicatorPadding: const EdgeInsets.symmetric(vertical: 4),
                  unselectedLabelStyle: theme.textTheme.displayMedium,
                  dividerHeight: 0,
                  labelStyle: theme.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                  onTap: (value) {
                    setState(() {
                      selectedSource = source.sources[value].id;
                    });
                    getArticles();
                  },
                  tabs: source.sources.map((e) {
                    return Tab(child: Text(e.name));
                  }).toList(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          if (isLoading && selectedSource != null)
            const Center(child: CircularProgressIndicator())
          else if (errorMessage != null && errorMessage!.isNotEmpty)
            Center(child: Text(errorMessage!))
          else if (articles.isNotEmpty)
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: articles.length + 1,
              itemBuilder: (context, index) {
                if (index == articles.length) {
                  return ElevatedButton(
                    onPressed: () {
                      setState(() {
                        isLoadMoreButtonClicked = true;
                      });
                      currentPage++;
                      getArticles();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: ContinuousRectangleBorder(
                        side: BorderSide(
                          color: (provider.theme == ThemeMode.light)
                              ? ColorsPalette.primaryBlackColor
                              : ColorsPalette.scaffoldBackground,
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
                            : Text(
                                lang.load_more_button,
                                style: theme.textTheme.bodySmall,
                              ),
                      ),
                    ),
                  );
                }
                var article = articles[index];
                return ArticleCardWidget(artcile: article);
              },
              separatorBuilder: (context, index) => const SizedBox(height: 16),
            ),
        ],
      ),
    );
  }

  Future<void> getArticles() async {
    final lang = AppLocalizations.of(context)!;

    if (!isLoadMoreButtonClicked) {
      articles.clear();
      setState(() {
        isLoading = true;
      });
    }
    try {
      var fetch = await Requests.getArticles(
        source: selectedSource,
        page: currentPage.toString(),
      );
      if (fetch != null && fetch.articles.isNotEmpty) {
        articles.addAll(fetch.articles);
        errorMessage = null;
      } else {
        errorMessage = lang.news_no_articles_in_source;
      }
    } catch (e) {
      errorMessage = e.toString();
    }
    setState(() {
      if (isLoadMoreButtonClicked) {
        isLoadMoreButtonClicked = false;
      } else {
        isLoading = false;
      }
    });
  }
}
