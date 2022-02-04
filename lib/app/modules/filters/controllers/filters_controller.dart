import 'package:get/get.dart';

class FiltersController extends GetxController {
  //TODO: Implement FiltersController
RxList<String> selectedProperty = <String>[].obs;
RxList<String> selectedHouseType = <String>[].obs;
RxList<String> selectedKeyword = <String>[].obs;
RxList<int> indexesProp = <int>[].obs;
RxList<int> indexesHouseType = <int>[].obs;
RxList<int> indexesKeyword = <int>[].obs;

static FiltersController get to => Get.find();
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    selectedProperty.forEach((element) {});
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;

  void selectProperty({required int index,required String propertyType}){

    selectedProperty.contains(propertyType)
        ? selectedProperty.remove(propertyType)
        : selectedProperty.add(propertyType);

    indexesProp.contains(index)
        ? indexesProp.remove(index)
        : indexesProp.add(index);

    print(selectedProperty.length);
  }
void removeProperty({required int index,required String propertyType}){

    if(propertyType == selectedProperty[index]){
      selectedProperty.remove(propertyType);
    }else{
      print("No Match");
    }
  print(selectedProperty.length);
}

void selectHouseType({required int index,required String houseType}){

  selectedHouseType.contains(houseType)
      ? selectedHouseType.remove(houseType)
      : selectedHouseType.add(houseType);

  indexesHouseType.contains(index)
      ? indexesHouseType.remove(index)
      : indexesHouseType.add(index);

  print(selectedProperty.length);
}
void removeHouseType({required int index,required String houseType}){

  if(houseType == selectedHouseType[index]){
    selectedHouseType.remove(houseType);
  }else{
    print("No Match");
  }
  print(selectedHouseType.length);
}



void selectKeyword({required int index,required String keyword}){

  selectedKeyword.contains(keyword)
      ? selectedKeyword.remove(keyword)
      : selectedKeyword.add(keyword);

  indexesKeyword.contains(index)
      ? indexesKeyword.remove(index)
      : indexesKeyword.add(index);

  print(selectedProperty.length);
}
void removeKeyword({required int index,required String keyword}){

  if(keyword == selectedKeyword[index]){
    selectedKeyword.remove(keyword);
  }else{
    print("No Match");
  }
  print(selectedKeyword.length);
}
}
