import 'package:flutter/material.dart';
import 'package:news_app_task/api/requests.dart';
import 'package:news_app_task/core/models/article_model.dart';
import 'package:news_app_task/core/theme_manager/colors_palette.dart';
import 'package:news_app_task/modules/home/widgets/article_card_widget.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? query;
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
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
                    });
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
                  const Center(child: Text('at least 5 chars to search'))
                else
                  FutureBuilder(
                    future: Requests.getQuertArticles(query!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (snapshot.hasError) {
                        return Center(
                          child: Text("There's error: ${snapshot.error}"),
                        );
                      }
                      if (!snapshot.hasData) {
                        return const Center(
                          child: Text('No Articles with your search'),
                        );
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          ArticleData artcile = snapshot.data!.articles[index];
                          return ArticleCardWidget(artcile: artcile);
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemCount: snapshot.data!.articles.length,
                      );
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
