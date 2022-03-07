import 'package:perfect/app/models/about_company.dart';

class ApiSettings{
  static const BASE_URL_API = "https://look4us.online/api/";
  static const REGISTER_USER = BASE_URL_API + "register";
  static const LOGIN_USER = BASE_URL_API + "login";
  static const SENDOTP = BASE_URL_API + "sendotp";
  static const RESETPASSWORD = BASE_URL_API + "resetpassword";
  static const LOGOUT_USER = BASE_URL_API + "logout";
  static const HOMEIMAGE = BASE_URL_API + "static?field=home_image";
  static const ABOUTCOMPANY = BASE_URL_API + "static?field=about_company";
  static const PROPERTYTYPE = BASE_URL_API + "static?field=property_types";
  static const HouseTypes = BASE_URL_API + "static?field=house_types";
  static const EXTRASCREEN = BASE_URL_API + "static?field=extra_screen";
  static const HOWTOEDITPROFILE = BASE_URL_API + "static?field=guide_videos";
  static const PRIVACYPOLICY = BASE_URL_API + "static?field=privacy_policy";
  static const TERMSOFUSE = BASE_URL_API + "static?field=terms_of_use";
  static const SEARCH = BASE_URL_API + "search";
  static const COMPANYDETAILS = BASE_URL_API + "company/detail?company_id=";
  static const SAVECOMPANYPROFILE = BASE_URL_API + "company/save";
  static const CONTACT = BASE_URL_API + "contact";
  static const RECOMMENDTOFRIEND = BASE_URL_API + "recommend";
  static const REPORTCOMPANY = BASE_URL_API + "company/report";
  static const FAVOURATE = BASE_URL_API + "company/favorite";
  static const GETFAVOURATE = BASE_URL_API + "favorites";



}