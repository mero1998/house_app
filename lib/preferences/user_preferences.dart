

import 'package:perfect/app/models/language.dart';
import 'package:perfect/app/models/user.dart';
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

  Future save(User user) async {
    await _sharedPreferences.setBool('logged_in', true);
    await _sharedPreferences.setInt('id', user.data.id!);
    await _sharedPreferences.setString('token', user.token);
    await _sharedPreferences.setString('email', user.data.email!);
    await _sharedPreferences.setString('name', user.data.name!);
    await _sharedPreferences.setString('type', user.data.type!);
  }

  int get id => _sharedPreferences.getInt('id') ?? 0;
  String get email => _sharedPreferences.getString('email') ?? "";
  String get name => _sharedPreferences.getString('name') ?? "";
  String get type => _sharedPreferences.getString('type') ?? "";
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

  String getToken(){
    String token = _sharedPreferences.getString("token") ?? "";
    return "Bearer $token";
    // return token;
  }
}
