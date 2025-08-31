import 'package:flutter/material.dart';
import 'package:news_app_task/api/requests.dart';
import 'package:news_app_task/core/models/article_model.dart';
import 'package:news_app_task/core/models/source_model.dart';
import 'package:news_app_task/core/theme_manager/colors_palette.dart';
import 'package:news_app_task/modules/home/widgets/article_card_widget.dart';

class HomeListNewsWidget extends StatefulWidget {
  final String categoryToApi;
  const HomeListNewsWidget({super.key, required this.categoryToApi});

  @override
  State<HomeListNewsWidget> createState() => _HomeListNewsWidgetState();
}

class _HomeListNewsWidgetState extends State<HomeListNewsWidget> {
  String? selectedSource;
  late Future<SourceModel?> sourcesFuture;

  @override
  void initState() {
    super.initState();
    sourcesFuture = Requests.getSources(widget.categoryToApi).then((value) {
      if (value != null && value.sources.isNotEmpty) {
        setState(() {
          selectedSource = value.sources.first.id;
        });
      }
      return value;
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
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
                return const Center(
                  child: Text('unexpected error to get sources'),
                );
              }
              if (!snapshot.hasData) {
                return const Center(child: Text('No Sources'));
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
                  },
                  tabs: source.sources.map((e) {
                    return Tab(child: Text(e.name));
                  }).toList(),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          if (selectedSource != null)
            FutureBuilder(
              future: Requests.getArticles(source: selectedSource!),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'unexpected error to get artciles ${snapshot.error}',
                    ),
                  );
                }
                if (!snapshot.hasData) {
                  return Center(child: Text('No Artciles ${snapshot.error}'));
                }

                final List<ArticleData> artciles = snapshot.data!.articles;

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: artciles.length,
                  itemBuilder: (context, index) {
                    var artcile = artciles[index];
                    return ArticleCardWidget(artcile: artcile);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 16),
                );
              },
            ),
        ],
      ),
    );
  }
}
