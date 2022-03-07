import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfect/app/data/constants.dart';
import 'package:perfect/app/modules/editprofile/controllers/editprofile_controller.dart';
import 'package:perfect/app/modules/filterresults/controllers/filterresults_controller.dart';
import 'package:perfect/app/modules/filters/controllers/filters_controller.dart';
import 'package:get/get.dart';
class SelectHouseType extends StatefulWidget {

  bool isFilter;


  SelectHouseType({ required this.isFilter,});

  @override
  State<SelectHouseType> createState() => _SelectPropertyTypeState();
}

class _SelectPropertyTypeState extends State<SelectHouseType> {



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("House Type"),
        centerTitle: true,
      ),
    body: Padding(
      padding:  EdgeInsets.symmetric(
          horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 10),
        child: SizedBox(
          // height: SizeConfig.scaleHeight(currencyPv.cList.length*80),
          child: Obx(() {
             return ListView.separated(
               padding: EdgeInsets.all(10),
               separatorBuilder: (ctx,index)=>Divider(),
               itemCount: FiltersController.to.houseTypes.length,
               itemBuilder: (ctx,index)=>
                   InkWell(
                     onTap: (){
                       widget.isFilter ?  FiltersController.to.selectHouseType(index:index,houseType:FiltersController.to.houseTypes[index]! )
                           : EditprofileController.to.selectHouseType(index: index, houseType:FiltersController.to.houseTypes[index]!);
                       print(FiltersController.to.indexesHouseType);
                       print(FiltersController.to.selectedHouseType);

                     },
                     // child: GetX(
                     //   builder: ( FiltersController controller ) {
                     //     return Row(
                     //       children: [
                     //         Text(controller.houseTypes[index]!.name!),
                     //         Spacer(),
                     //         Visibility(
                     //             visible: widget.isFilter ? controller.indexesHouseType.contains(index): indexs.contains(index),
                     //             child: Icon(Icons.check,color: mainColor,)),
                     //       ],
                     //     );
                     //   },
                     //
                     // ),
                    child: Obx((){
                      return Row(
                                children: [
                                  Text(FiltersController.to.houseTypes[index]!.name!),
                                  Spacer(),
                                  Visibility(
                                      visible: widget.isFilter ? FiltersController.to.indexesHouseType.contains(index): EditprofileController.to.selectedHouseTypeIndex.contains(index),
                                      child: Icon(Icons.check,color: mainColor,)),
                                ],
                              );
                    }),
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
