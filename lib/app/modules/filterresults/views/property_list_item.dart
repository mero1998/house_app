import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect/app/models/property.dart';
import 'package:perfect/app/routes/app_pages.dart';

class PropertyListItem extends StatelessWidget {

  final Property property;
  PropertyListItem({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed(Routes.PROPERTYDETAILS);
      },
      child: Container(
          decoration: BoxDecoration( //                    <-- BoxDecoration
            border: Border(bottom: BorderSide(color: Colors.black45),),

          ),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 5,),
              SizedBox(
                height: 80.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                    property.medias?.length,
                    itemBuilder:
                        (BuildContext context, int index) {
                      return getImageListItem(property.medias![index].image!);
                    }),
              ),

              _getInfoRow("assets/image/icon_title.png", property.name!),
              SizedBox(height: 5,),
              _getInfoRow("assets/image/icon_city.png", property.city!),
              SizedBox(height: 5,),
              _getInfoRow("assets/image/icon_address.png", property.address!),
              SizedBox(height: 5,),
              _getInfoRow("assets/image/icon_phone.png", property.contactNo!),

              SizedBox(height: 15,),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getInfoRow(String icon, String data){
    return Container(
      child: Row(
        children: [
          Image.asset(icon, width: 15,),
          SizedBox(width: 10,),
          Flexible(child: Text(data, style: TextStyle(fontSize: 14, color: Colors.black54),)),
        ],
      ),
    );
  }

  Widget getImageListItem(String img){
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Image.asset(img, width: 55,),
    );
  }

}
