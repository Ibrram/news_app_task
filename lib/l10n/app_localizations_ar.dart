// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get home => 'الرئيسية';

  @override
  String get welcoming_home => 'مرحبا\nهناك بعض الاخبار لك';

  @override
  String get view_all => 'مشاهدة الجميع';

  @override
  String get drawer_app_name => 'تطبيق الأخبار';

  @override
  String get drawer_home_button => 'الذهاب للرئيسية';

  @override
  String get drawer_change_theme => 'الوضع';

  @override
  String get drawer_change_lang => 'اللغة';

  @override
  String get theme_mode_light => 'فاتح';

  @override
  String get theme_mode_dark => 'داكن';

  @override
  String get news_sources_unexpected_error => 'حصل خطأ مع المصادر';

  @override
  String get news_no_sources => 'لايوجد مصادر';

  @override
  String get news_no_articles_in_source => 'مفيش أخبار للمصدر ده';

  @override
  String get article_author => 'بقلم';

  @override
  String get publish_time_seconds => 'من الثواني';

  @override
  String get publish_time_minutes => 'من الدقائق';

  @override
  String get publish_time_hours => 'من الساعات';

  @override
  String get publish_time_days => 'من ألايام';

  @override
  String get publish_time_months => 'من الشهور';

  @override
  String get publish_time_years => 'من السنين';

  @override
  String get load_more_button => 'عرض المزيد';

  @override
  String get view_article_button => 'عرض الخبر كامل';

  @override
  String get search => 'بحث';

  @override
  String get search_query_condition => 'اكتب 5 حروف على الأقل للبحث';

  @override
  String get search_query_no_article => 'مفيش أخبار بالكلمة دي';

  @override
  String get category_name_general => 'عام';

  @override
  String get category_name_business => 'أعمال';

  @override
  String get category_name_sports => 'رياضة';

  @override
  String get category_name_technology => 'تكنولوجيا';

  @override
  String get category_name_science => 'علوم';

  @override
  String get category_name_health => 'صحة';

  @override
  String get category_name_entertainment => 'تسلية';
}
