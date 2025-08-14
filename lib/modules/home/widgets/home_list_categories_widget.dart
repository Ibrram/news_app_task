import 'package:flutter/material.dart';
import 'package:news_app_task/modules/home/widgets/category_card_widget.dart';

class HomeListCategoriesWidget extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
  final Function(String) onTap;
  const HomeListCategoriesWidget({
    super.key,
    required this.categories,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Column(
      spacing: 16,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Good Morning\nHere is Some News For You',
          style: theme.textTheme.bodyLarge,
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            Map<String, dynamic> current = categories[index];
            Alignment align = index % 2 == 0
                ? Alignment.bottomRight
                : Alignment.bottomLeft;

            return CategoryCardWidget(
              category: current,
              align: align,
              onTap: () => onTap(current['name']),
            );
          },
          separatorBuilder: (context, index) => const SizedBox(height: 16),
          itemCount: categories.length,
        ),
      ],
    );
  }
}
