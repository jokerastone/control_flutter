import 'package:get/get.dart';
import '../pages/home_page.dart';
import '../pages/detail_page.dart';
import '../pages/profile_page.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.detail,
      page: () => const DetailPage(),
      transition: Transition.rightToLeft,
    ),
    // GetPage(
    //   name: AppRoutes.profile,
    //   page: () => const ProfilePage(),
    //   transition: Transition.downToUp,
    // ),
  ];
}