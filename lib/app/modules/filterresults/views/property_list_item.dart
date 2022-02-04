import 'package:cached_network_image/cached_network_image.dart';
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
                height: 130.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                    property.medias?.length,
                    itemBuilder:
                        (BuildContext context, int index) {
                      return Container(
                          child: getImageListItem( context,property.medias![index].image!));
                    }),
              ),
              SizedBox(height: 10,),

              _getInfoRow("assets/image/icon_title.png", property.name!),
              SizedBox(height: 5,),
              // _getInfoRow("assets/image/icon_city.png", property.city!),
              // _getInfoRow("assets/image/icon_address.png", property.address!),
              // _getInfoRow("assets/image/icon_phone.png", property.contactNo!),

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

  Widget getImageListItem(BuildContext context,String img){

   return Container(
      // height: 90,
      decoration: BoxDecoration(
          border: Border.all()
      ),
      margin: EdgeInsetsDirectional.all(2),
      child: Column(
        children: [
          CachedNetworkImage(
            width: MediaQuery.of(context).size.width / 6 - 8.8,
            height: 70,
            fit: BoxFit.cover,
            imageUrl: "https://media.istockphoto.com/photos/dream-home-luxury-house-success-suburban-house-picture-id1281554848?b=1&k=20&m=1281554848&s=170667a&w=0&h=s7X81b-3hfEGTYVkFKDOG7ZDySs57Tpw_WAETXi5xnQ=",
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error, size: 60,),
          ),
          Text("Word"),
          Divider(),
          Text("\$55")
        ],
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.all(2.0),
    //   child: Image.asset(img, width: MediaQuery.of(context).size.width / 5 - 10,fit: BoxFit.cover,),
    // );
  }

}
