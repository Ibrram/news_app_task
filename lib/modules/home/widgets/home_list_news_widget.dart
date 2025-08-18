import 'package:flutter/material.dart';
import 'package:news_app_task/api/requests.dart';
import 'package:news_app_task/core/models/source_model.dart';

class HomeListNewsWidget extends StatefulWidget {
  final String categoryToApi;
  const HomeListNewsWidget({super.key, required this.categoryToApi});

  @override
  State<HomeListNewsWidget> createState() => _HomeListNewsWidgetState();
}

class _HomeListNewsWidgetState extends State<HomeListNewsWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FutureBuilder(
          future: Requests.getSources(widget.categoryToApi),
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
                tabs: source.sources.map((e) {
                  return Tab(child: Text(e.name));
                }).toList(),
              ),
            );
          },
        ),
      ],
    );
  }
}
