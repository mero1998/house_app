import 'package:flutter/material.dart';
import 'package:perfect/app/data/constants.dart';
import 'package:perfect/app/modules/filters/controllers/filters_controller.dart';
import 'package:get/get.dart';
class SelectKeyword extends StatefulWidget {

  @override
  State<SelectKeyword> createState() => _SelectKeywordState();
}

class _SelectKeywordState extends State<SelectKeyword> {
  List<String> keyword =  [
  "Residential Properties",
  "Commercial Properties",
  "Vacant Land"
  ];

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
          child: ListView.separated(
            padding: EdgeInsets.all(10),
            separatorBuilder: (ctx,index)=>Divider(),
            itemCount: 3,
            itemBuilder: (ctx,index)=>
                InkWell(
                  onTap: (){
                  FiltersController.to.selectKeyword(index:index,keyword:keyword[index] );
                   print(FiltersController.to.indexesProp);
                   print(FiltersController.to.selectedProperty);

                  },
                  child: GetX(
                    builder: (FiltersController controller) {
                      return Row(
                        children: [
                          Text(keyword[index]),
                          Spacer(),
                          Visibility(
                              visible: controller.indexesKeyword.contains(index),
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
