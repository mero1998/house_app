class Language{
  late int id;
  late String name;
  late String flag;
  late String languageCode;

  Language({required this.id,required this.name,required this.flag,required this.languageCode});

 static List<Language>  listLanguages =[
    Language(id: 1, name: "English", flag: "🇬🇧", languageCode: "en"),
    Language(id: 2, name: "French", flag: "🇫🇷", languageCode: "fr"),
    Language(id: 3, name: "Spanish", flag: "🇪🇸", languageCode: "es"),
    Language(id: 4, name: "Germany", flag: "🇩🇪", languageCode: "de"),
    Language(id: 5, name: "Chinese", flag: "🇨🇳", languageCode: "cn"),
    Language(id: 6, name: "Japanese", flag: "🇯🇵", languageCode: "jp"),
  ];

}