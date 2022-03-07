import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:perfect/app/models/property.dart';
import 'package:perfect/app/models/saved_property.dart';
import 'package:perfect/app/models/search_result.dart';
import 'package:perfect/app/modules/propertydetails/controllers/propertydetails_controller.dart';
import 'package:perfect/app/modules/propertydetails/views/propertydetails_view.dart';
import 'package:perfect/app/routes/app_pages.dart';

class PropertyFavListItem extends StatelessWidget {

  final SavedProperty  property;
  PropertyFavListItem({Key? key, required this.property}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // PropertydetailsController controller = Get.put(PropertydetailsController());

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => PropertydetailsView(companyId: property.companyId!,),));
        // Get.toNamed(Routes.PROPERTYDETAILS);

        // PropertydetailsController.to.getCompanyDetails(companyId: property.companyId!);
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
                height: 150.0,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                    property.companyImages?.length,
                    itemBuilder:
                        (BuildContext context, int index) {
                      return Container(
                          child: getImageListItem( context,property.companyImages![index].imageUrl!,));
                    }),
              ),
              SizedBox(height: 10,),

              _getInfoRow("assets/image/icon_title.png", property.companyName ?? "N/A"),
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
            imageUrl: img,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
            errorWidget: (context, url, error) => Icon(Icons.error, size: 60,),
          ),
          Text(property.companyImages!.first.keyword ?? ""),
          Divider(),
          Text("\$ ${property.companyImages!.first.price ?? 0}")
        ],
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.all(2.0),
    //   child: Image.asset(img, width: MediaQuery.of(context).size.width / 5 - 10,fit: BoxFit.cover,),
    // );
  }

}
