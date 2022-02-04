

import 'package:perfect/app/models/language.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._();
  late SharedPreferences _sharedPreferences;

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._();

  Future<void> initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  // Future save(UserCredential user) async {
  //   await _sharedPreferences.setBool('logged_in', true);
  //   await _sharedPreferences.setString('id', user.user!.uid);
  //   await _sharedPreferences.setString('email', user.user!.email!);
  // }

  String get id => _sharedPreferences.getString('id') ?? "0";
  String get email => _sharedPreferences.getString('email') ?? "";
  String get codeLang => _sharedPreferences.getString('codeLang') ?? "en";

  bool get isLoggedIn => _sharedPreferences.getBool('logged_in') ?? false;


  Future<bool> logout() async {
    return await _sharedPreferences.clear();
  }

  Future saveLang(Language language) async {
    await _sharedPreferences.setString('codeLang', language.languageCode);
    await _sharedPreferences.setString('langName', language.name);
    await _sharedPreferences.setString('langFlag', language.flag);
  }
  Future<bool> setLang({required String langCode}) async{
    return await _sharedPreferences.setString("codeLang", langCode);
  }
}
