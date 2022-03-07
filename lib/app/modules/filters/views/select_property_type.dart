import 'package:flutter/material.dart';
import 'package:perfect/app/data/constants.dart';
import 'package:perfect/app/modules/editprofile/controllers/editprofile_controller.dart';
import 'package:perfect/app/modules/filters/controllers/filters_controller.dart';
import 'package:get/get.dart';
class SelectPropertyType extends StatefulWidget {

  bool isFilter;


  SelectPropertyType({ required this.isFilter,});
  @override
  State<SelectPropertyType> createState() => _SelectPropertyTypeState();
}

class _SelectPropertyTypeState extends State<SelectPropertyType> {
  // List<String> propertyType =  [
  // "Residential Properties",
  // "Commercial Properties",
  // "Vacant Land"
  // ];

  List<String> selected = [];

  List<int> indexes = [];

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Property Type"),
        centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.pop(context,selected);
        },
      ),
      ),
    body: Padding(
      padding:  EdgeInsets.symmetric(
          horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: SizedBox(
          // height: SizeConfig.scaleHeight(currencyPv.cList.length*80),
          child: GetX<FiltersController>(
           builder: (FiltersController controller) {
             print(controller.propertyTypes.length);
             return ListView.separated(
               padding: EdgeInsets.all(10),
               separatorBuilder: (ctx,index)=>Divider(),
               itemCount: controller.propertyTypes.length,
               itemBuilder: (ctx,index)=>
                   InkWell(
                     onTap: (){
                    widget.isFilter ?    FiltersController.to.selectProperty(index:index,propertyType:controller.propertyTypes[index]!)
                    : EditprofileController.to.selectProperty(index: index, propertyType: controller.propertyTypes[index]!);
                       print(FiltersController.to.indexesProp);
                       print(FiltersController.to.selectedProperty);

                     },
                    child: GetX<FiltersController>(
                     builder: (controller) {
                       return Row(
                         children: [
                           Text(controller.propertyTypes[index]!.name!),
                           Spacer(),
                           Visibility(
                               visible:widget.isFilter ? FiltersController.to.indexesProp.contains(index): EditprofileController.to.selectedPropertyTypeIndex.contains(index),
                               child: Icon(Icons.check,color: mainColor,)),
                         ],
                       );
                     },

                    ),
                   ),
             );
           },
          ),
        ),
      ),
    ),
    );
  }
}
