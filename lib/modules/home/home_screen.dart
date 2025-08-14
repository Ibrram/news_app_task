import 'package:flutter/material.dart';
import 'package:news_app_task/core/constants/app_assets.dart';
import 'package:news_app_task/core/theme_manager/colors_palette.dart';
import 'package:news_app_task/drawer/advanced_drawer.dart';
import 'package:news_app_task/drawer/advanced_drawer_controller.dart';
import 'package:news_app_task/modules/home/widgets/drawer_widget.dart';
import 'package:news_app_task/modules/home/widgets/home_list_categories_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategory;
  List<Map<String, dynamic>> categories = [
    {
      "name": "General",
      "category": "general",
      "banner": AppAssets.generalBannerImg,
    },
    {
      "name": "Business",
      "category": "business",
      "banner": AppAssets.businessBannerImg,
    },
    {
      "name": "Sports",
      "category": "sports",
      "banner": AppAssets.sportsBannerImg,
    },
    {
      "name": "Technology",
      "category": "technology",
      "banner": AppAssets.technologyBannerImg,
    },
    {
      "name": "Science",
      "category": "science",
      "banner": AppAssets.scienceBannerImg,
    },
    {
      "name": "Health",
      "category": "health",
      "banner": AppAssets.healthBannerImg,
    },
    {
      "name": "Entertainment",
      "category": "entertainment",
      "banner": AppAssets.entertainmentBannerImg,
    },
  ];
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return AdvancedDrawer(
      backdrop: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              ColorsPalette.primaryBlackColor,
              ColorsPalette.primaryBlackColor,
            ],
          ),
        ),
      ),
      controller: _advancedDrawerController,
      animationCurve: Curves.easeIn,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      childDecoration: const BoxDecoration(
        // NOTICE: Uncomment if you want to add shadow behind the page.
        // Keep in mind that it may cause animation jerks.
        // boxShadow: <BoxShadow>[
        //   BoxShadow(color: Colors.black12, blurRadius: 0.0),
        // ],
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),

      drawer: DrawerWidget(
        goToHomeTap: () {
          if (selectedCategory == null) return;
          setState(() {
            selectedCategory = null;
          });
          _advancedDrawerController.hideDrawer();
        },
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            selectedCategory ?? 'Home',
            style: theme.textTheme.bodyMedium,
          ),
          leading: IconButton(
            onPressed: () => _advancedDrawerController.showDrawer(),
            icon: const Icon(Icons.menu_open_outlined),
          ),
          actions: [const Icon(Icons.search, size: 25)],
        ),
        // drawer: const Drawer(),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: selectedCategory == null
                ? HomeListCategoriesWidget(
                    categories: categories,
                    onTap: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  )
                : const Text('empty'),
          ),
        ),
      ),
    );
  }
}
