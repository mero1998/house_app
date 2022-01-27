import 'package:get/get.dart';
import 'package:perfect/app/modules/subscription/bindings/subsciption_binding.dart';
import 'package:perfect/app/modules/subscription/views/subsciption_view.dart';

import '../modules/contact_us/bindings/contact_us_binding.dart';
import '../modules/contact_us/views/contact_us_view.dart';
import '../modules/editprofile/bindings/editprofile_binding.dart';
import '../modules/editprofile/views/editprofile_view.dart';
import '../modules/filterresults/bindings/filterresults_binding.dart';
import '../modules/filterresults/views/filterresults_view.dart';
import '../modules/filters/bindings/filters_binding.dart';
import '../modules/filters/views/filters_view.dart';
import '../modules/forgot_password/bindings/forgot_password_binding.dart';
import '../modules/forgot_password/views/forgot_password_view.dart';
import '../modules/halp/bindings/halp_binding.dart';
import '../modules/halp/views/halp_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/map/bindings/map_binding.dart';
import '../modules/map/views/map_view.dart';
import '../modules/propertydetails/bindings/propertydetails_binding.dart';
import '../modules/propertydetails/views/propertydetails_view.dart';
import '../modules/registration/bindings/registration_binding.dart';
import '../modules/registration/views/registration_view.dart';
import '../modules/search/bindings/search_binding.dart';
import '../modules/search/views/search_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRATION,
      page: () => RegistrationView(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT_PASSWORD,
      page: () => ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: _Paths.CONTACT_US,
      page: () => ContactUsView(),
      binding: ContactUsBinding(),
    ),
    GetPage(
      name: _Paths.SEARCH,
      page: () => SearchView(),
      binding: SearchBinding(),
    ),
    GetPage(
      name: _Paths.FILTERS,
      page: () => FiltersView(),
      binding: FiltersBinding(),
    ),
    GetPage(
      name: _Paths.FILTERRESULTS,
      page: () => FilterresultsView(),
      binding: FilterresultsBinding(),
    ),
    GetPage(
      name: _Paths.MAP,
      page: () => MapView(),
      binding: MapBinding(),
    ),
    GetPage(
      name: _Paths.PROPERTYDETAILS,
      page: () => PropertydetailsView(),
      binding: PropertydetailsBinding(),
    ),
    GetPage(
      name: _Paths.EDITPROFILE,
      page: () => EditprofileView(),
      binding: EditprofileBinding(),
    ),
    GetPage(
      name: _Paths.SUBSCIPTION,
      page: () => SubsciptionView(),
      binding: SubsciptionBinding(),
    ),
    GetPage(
      name: _Paths.HALP,
      page: () => HalpView(),
      binding: HalpBinding(),
    ),
  ];
}
