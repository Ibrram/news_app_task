import 'package:flutter/material.dart';
import 'package:news_app_task/core/constants/app_assets.dart';
import 'package:news_app_task/core/routes/routes_name.dart';
import 'package:news_app_task/core/theme_manager/colors_palette.dart';
import 'package:news_app_task/drawer/advanced_drawer.dart';
import 'package:news_app_task/drawer/advanced_drawer_controller.dart';
import 'package:news_app_task/l10n/app_localizations.dart';
import 'package:news_app_task/modules/home/pages/home_list_categories_widget.dart';
import 'package:news_app_task/modules/home/pages/home_list_news_widget.dart';
import 'package:news_app_task/modules/home/widgets/drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCategory;
  String? categoryToApi;
  final _advancedDrawerController = AdvancedDrawerController();
  @override
  Widget build(BuildContext context) {
    AppLocalizations lang = AppLocalizations.of(context)!;
    String currentLocale = Localizations.localeOf(context).languageCode;
    var theme = Theme.of(context);
    List<Map<String, dynamic>> categories = [
      {
        "name": lang.category_name_general,
        "category": "general",
        "banner": AppAssets.generalBannerImg,
      },
      {
        "name": lang.category_name_business,
        "category": "business",
        "banner": AppAssets.businessBannerImg,
      },
      {
        "name": lang.category_name_sports,
        "category": "sports",
        "banner": AppAssets.sportsBannerImg,
      },
      {
        "name": lang.category_name_technology,
        "category": "technology",
        "banner": AppAssets.technologyBannerImg,
      },
      {
        "name": lang.category_name_science,
        "category": "science",
        "banner": AppAssets.scienceBannerImg,
      },
      {
        "name": lang.category_name_health,
        "category": "health",
        "banner": AppAssets.healthBannerImg,
      },
      {
        "name": lang.category_name_entertainment,
        "category": "entertainment",
        "banner": AppAssets.entertainmentBannerImg,
      },
    ];
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
      rtlOpening: currentLocale == "ar" ? true : false,
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
          // delay to hide Advanced Drawer with the animation
          Future.delayed(const Duration(milliseconds: 50), () {
            _advancedDrawerController.hideDrawer();
          });
        },
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            selectedCategory ?? lang.home,
            style: theme.textTheme.bodyMedium,
          ),
          leading: IconButton(
            onPressed: () => _advancedDrawerController.showDrawer(),
            icon: const Icon(Icons.menu_open_outlined),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, RoutesName.search);
              },
              // constraints: const BoxConstraints(),
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.search, size: 25),
            ),
          ],
        ),
        // drawer: const Drawer(),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: selectedCategory == null
                ? HomeListCategoriesWidget(
                    categories: categories,
                    onTap: (category, categoryId) {
                      setState(() {
                        selectedCategory = category;
                        categoryToApi = categoryId;
                      });
                    },
                  )
                : HomeListNewsWidget(categoryToApi: categoryToApi!),
          ),
        ),
      ),
    );
  }
}
