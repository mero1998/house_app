import 'package:get/get.dart';
import 'package:perfect/app/models/language.dart';
import 'package:perfect/preferences/user_preferences.dart';

class SelectLanguageController extends GetxController{

  Language? selectedLang;
  RxString langCode = "".obs;
 @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    print(langCode);
    // selectedLang == null ?selectedLang = Language.listLanguages.first :
    // Language.listLanguages.forEach((element) {
    //   if(element.languageCode == langCode){
    //     print("From Build:::: ${element.languageCode}");
    //     selectedLang = element;
    //   }
    // });
    setLang();

}
  void changeLanguage(String language){
    print(language);
      // selectedLang = language;
    langCode.value = language;
    print("From Controller: $langCode");

  }

  void setLang(){
    switch(UserPreferences().codeLang) {
      case "en":
        selectedLang = Language.listLanguages.elementAt(0);
        break;
      case "fr":
        selectedLang = Language.listLanguages.elementAt(1);
        break;
      case "es":
        selectedLang = Language.listLanguages.elementAt(2);
        break;
      case "de":
        selectedLang = Language.listLanguages.elementAt(3);
        break;
      case "cn":
        selectedLang = Language.listLanguages.elementAt(4);
        break;
      case "jp":
        selectedLang = Language.listLanguages.elementAt(5);
        break;

    }
  }
  // void readList(){
  //   languges.value = listLanguages;
  // }
}