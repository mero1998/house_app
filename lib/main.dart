import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:perfect/app/modules/contact_us/views/contact_us_view.dart';
import 'package:perfect/app/modules/editprofile/views/editprofile_view.dart';
import 'package:perfect/app/modules/filterresults/views/filterresults_view.dart';
import 'package:perfect/app/modules/filters/views/filters_view.dart';
import 'package:perfect/app/modules/filters/views/select_property_type.dart';
import 'package:perfect/app/modules/home/views/home_view.dart';
import 'package:perfect/app/modules/login/views/login_view.dart';
import 'package:perfect/app/modules/propertydetails/views/propertydetails_view.dart';
import 'package:perfect/app/modules/recommend_to_frind/views/recommend_to_friend_view.dart';
import 'package:perfect/app/modules/registration/views/registration_view.dart';
import 'package:perfect/app/modules/splash/views/splash_view.dart';
import 'package:perfect/preferences/user_preferences.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().initPreferences();
    InAppPurchaseConnection.enablePendingPurchases();
  runApp(
    GetMaterialApp(
      title: "Application",
      // initialRoute: Routes.SPLASH,
      // routes: {
      //   Routes.SPLASH : (context) => SplashView(),
      //   Routes.HOME : (context) => HomeView(),
      //   Routes.REGISTRATION : (context) => RegistrationView(),
      //   Routes.LOGIN : (context) => LoginView(),
      //   Routes.RECOMMENDTOFRIEND : (context) => RecommendToFriendView(),
      //   Routes.CONTACT_US : (context) => ContactUsView(),
      //   Routes.SELECT_PROPERTY_TYEP : (context) => SelectPropertyType(),
      //   Routes.EDITPROFILE : (context) => EditprofileView(),
      //   Routes.FILTERRESULTS : (context) => FilterresultsView(),
      //   Routes.FILTERS : (context) => FiltersView(),
      //   Routes.PROPERTYDETAILS : (context) => PropertydetailsView(),
      // },
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade600,
        )
      ),
    ),
  );
}
