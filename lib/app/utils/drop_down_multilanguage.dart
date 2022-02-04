import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect/app/models/language.dart';
import 'package:perfect/app/modules/select_language/controller/select_language_contoller.dart';
import 'package:perfect/preferences/user_preferences.dart';

class DropDownMultiLanguage extends StatefulWidget {
  const DropDownMultiLanguage({Key? key}) : super(key: key);

  @override
  _DropDownMultiLanguageState createState() => _DropDownMultiLanguageState();
}

class _DropDownMultiLanguageState extends State<DropDownMultiLanguage> {
  SelectLanguageController controller = Get.put(SelectLanguageController());

  @override
  Widget build(BuildContext context) {
  print(controller.selectedLang);
  // controller.selectedLang == null ? print("true") : print("False");
  // selectedLang == null ?selectedLang = Language.listLanguages.first :
  // Language.listLanguages.forEach((element) {
  //   if(element.languageCode == langCode){
  //     print("From Build:::: ${element.languageCode}");
  //     selectedLang = element;
  //   }
  // });

  Language.listLanguages.forEach((element) {
    if(element.languageCode == UserPreferences().codeLang){
    print("Good");
      controller.selectedLang == element;
    }
  });

    return Container(
      width: 66,
      height: 15,
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.white
          ),
          borderRadius: BorderRadius.circular(10)
      ),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(3),
      child: DropdownButtonFormField<Language>(
        iconEnabledColor: Colors.white,
        onChanged: (Language? lang){
          print("From Widget :: ${lang!.languageCode}");
          // setState(() {
          //   lang = controller.selectedLang;
          // });
          // lang != null ?  controller.changeLanguage(lang.languageCode) : print("Null");

          UserPreferences().setLang(langCode: lang.languageCode);
          controller.setLang();
          // controller.changeLanguage(lang.languageCode);
        },
        // icon: Text(selectedLang!),
        decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.only(
              left: 4,
              right: 4,
            ),

            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none

              // borderSide: Border.all()
            )
        ),
        value: controller.selectedLang,
        items: Language.listLanguages
            .map<DropdownMenuItem<Language>>((lang) => DropdownMenuItem(
          value: lang,
          child: Center(child: Text(lang.flag, style: TextStyle(fontSize: 20),)),
        ) ).toList(),
        onSaved: (newValue) {
          print(newValue);
        },
      ),
    );
  }
}
