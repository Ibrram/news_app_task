// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get welcoming_home => 'Good Morning\nHere is Some News For You';

  @override
  String get view_all => 'View All';

  @override
  String get drawer_app_name => 'News App';

  @override
  String get drawer_home_button => 'Go To Home';

  @override
  String get drawer_change_theme => 'Theme';

  @override
  String get drawer_change_lang => 'Language';

  @override
  String get theme_mode_light => 'Light';

  @override
  String get theme_mode_dark => 'Dark';

  @override
  String get news_sources_unexpected_error => 'Unexpected Error to get Sources';

  @override
  String get news_no_sources => 'No Sources';

  @override
  String get news_no_articles_in_source =>
      'Cannot get News Related to this Source';

  @override
  String get article_author => 'by';

  @override
  String get publish_time_seconds => 'seconds ago';

  @override
  String get publish_time_minutes => 'minutes ago';

  @override
  String get publish_time_hours => 'hours ago';

  @override
  String get publish_time_days => 'days ago';

  @override
  String get publish_time_months => 'months ago';

  @override
  String get publish_time_years => 'years ago';

  @override
  String get load_more_button => 'Load More';

  @override
  String get view_article_button => 'View Full Article';

  @override
  String get search => 'Search';

  @override
  String get search_query_condition => 'at Least 5 Characters to Search';

  @override
  String get search_query_no_article => 'No Articles with your search';

  @override
  String get category_name_general => 'General';

  @override
  String get category_name_business => 'Business';

  @override
  String get category_name_sports => 'Sports';

  @override
  String get category_name_technology => 'Technology';

  @override
  String get category_name_science => 'Science';

  @override
  String get category_name_health => 'Health';

  @override
  String get category_name_entertainment => 'Entertainment';
}
