import 'package:get/get.dart';
import 'package:perfect/app/models/media.dart';
import 'package:perfect/app/models/property.dart';

class FilterresultsController extends GetxController {

  var propertyList = <Property>[].obs;
  var  medias = <Media>[];
  var  medias1 = <Media>[];
  var  medias2 = <Media>[];

   @override
  void onInit() {
    super.onInit();
    getPropertyList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  void getPropertyList() {



     medias.add(Media(image: "assets/image/prop_1.png"));
     medias.add(Media(image: "assets/image/prop_2.png"));
     medias.add(Media(image: "assets/image/prop_3.png"));
     medias.add(Media(image: "assets/image/prop_4.png"));
     medias.add(Media(image: "assets/image/prop_5.png"));
     medias.add(Media(image: "assets/image/logo_1.png"));


     propertyList.add(Property(name: "ABC company name", address: "78587 Newcastle, Calabasas, California",
         city: "California", contactNo: "9876543210", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Enim at scelerisque porttitor erat bibendum. Venenatis sed non, aenean enim pulvinar arcu in porta. Turpis eu suspendisse netus nunc duis commodo imperdiet euismod ultrices. Odio dictumst non tortor ut tincidunt. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Enim at scelerisque porttitor erat bibendum. Venenatis sed non, aenean enim pulvinar arcu in porta. Turpis eu suspendisse netus nunc duis commodo imperdiet euismod ultrices. Odio dictumst non tortor ut tincidunt",
         latitude: "0.0", longitude: "0.0", medias: medias));

     medias1.add(Media(image: "assets/image/prop_11.png"));
     medias1.add(Media(image: "assets/image/prop_12.png"));
     medias1.add(Media(image: "assets/image/prop_13.png"));
     medias1.add(Media(image: "assets/image/prop_14.png"));
     medias1.add(Media(image: "assets/image/prop_15.png"));
     medias1.add(Media(image: "assets/image/logo_2.png"));

     propertyList.add(Property(name: "ABC company name", address: "78587 Newcastle, Calabasas, California",
         city: "California", contactNo: "9876543210", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Enim at scelerisque porttitor erat bibendum. Venenatis sed non, aenean enim pulvinar arcu in porta. Turpis eu suspendisse netus nunc duis commodo imperdiet euismod ultrices. Odio dictumst non tortor ut tincidunt. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Enim at scelerisque porttitor erat bibendum. Venenatis sed non, aenean enim pulvinar arcu in porta. Turpis eu suspendisse netus nunc duis commodo imperdiet euismod ultrices. Odio dictumst non tortor ut tincidunt",
         latitude: "0.0", longitude: "0.0", medias: medias1));

     medias2.add(Media(image: "assets/image/prop_1.png"));
     medias2.add(Media(image: "assets/image/prop_12.png"));
     medias2.add(Media(image: "assets/image/prop_3.png"));
     medias2.add(Media(image: "assets/image/prop_14.png"));
     medias2.add(Media(image: "assets/image/prop_16.png"));
     medias2.add(Media(image: "assets/image/add_logo.png"));

     propertyList.add(Property(name: "ABC company name", address: "78587 Newcastle, Calabasas, California",
         city: "California", contactNo: "9876543210", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Enim at scelerisque porttitor erat bibendum. Venenatis sed non, aenean enim pulvinar arcu in porta. Turpis eu suspendisse netus nunc duis commodo imperdiet euismod ultrices. Odio dictumst non tortor ut tincidunt. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Enim at scelerisque porttitor erat bibendum. Venenatis sed non, aenean enim pulvinar arcu in porta. Turpis eu suspendisse netus nunc duis commodo imperdiet euismod ultrices. Odio dictumst non tortor ut tincidunt",
         latitude: "0.0", longitude: "0.0", medias: medias2));


  }

}
