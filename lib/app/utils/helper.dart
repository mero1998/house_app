import 'package:html/parser.dart' show parse;

class Helper{

  static String parseHtmlString(String htmlString) {

     var document = parse(htmlString);

     String parsedString = parse(document.body!.text).documentElement!.text;
     print(parsedString);
     return parsedString;
   }
}