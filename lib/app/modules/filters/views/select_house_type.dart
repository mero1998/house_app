import 'package:flutter/material.dart';
import 'package:perfect/app/data/constants.dart';
import 'package:perfect/app/modules/filters/controllers/filters_controller.dart';
import 'package:get/get.dart';
class SelectHouseType extends StatefulWidget {

  @override
  State<SelectHouseType> createState() => _SelectPropertyTypeState();
}

class _SelectPropertyTypeState extends State<SelectHouseType> {
  List<String> houseType =  [
  "Residential Properties",
  "Commercial Properties",
  "Vacant Land"
  ];



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      appBar: AppBar(
        title: Text("Property Type"),
        centerTitle: true,
      ),
    body: Padding(
      padding:  EdgeInsets.symmetric(
          horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: SizedBox(
          // height: SizeConfig.scaleHeight(currencyPv.cList.length*80),
          child: ListView.separated(
            padding: EdgeInsets.all(10),
            separatorBuilder: (ctx,index)=>Divider(),
            itemCount: 3,
            itemBuilder: (ctx,index)=>
                InkWell(
                  onTap: (){
                  FiltersController.to.selectHouseType(index:index,houseType:houseType[index] );
                   print(FiltersController.to.indexesProp);
                   print(FiltersController.to.selectedHouseType);

                  },
                  child: GetX(
                    builder: (FiltersController controller) {
                      return Row(
                        children: [
                          Text(houseType[index]),
                          Spacer(),
                          Visibility(
                              visible: controller.indexesHouseType.contains(index),
                              child: Icon(Icons.check,color: mainColor,)),
                        ],
                      );
                    },

                  ),
                ),
          ),
        ),
      ),
    ),
    );
  }
}
