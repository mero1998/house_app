import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';


class ExtraPage extends StatelessWidget {
  const ExtraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
        "assets/image/logo-house-app.png",
        width: 160,
      ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 70),
        child: ListView(
          children: [
            ListView.builder(
              itemCount: 3,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                  return  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 5,

                    child: CachedNetworkImage(
                      imageUrl: "http://via.placeholder.com/350x150",
                      progressIndicatorBuilder: (context, url, downloadProgress) =>
                          CircularProgressIndicator(value: downloadProgress.progress),
                      errorWidget: (context, url, error) => Icon(Icons.error, size: 60,),
                    ),
                  );
                },),

            Text("This Will be an affliate link to cridit card company"),
            Text("Text with link external company of my choise"),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 5,

              child: CachedNetworkImage(
                imageUrl: "http://via.placeholder.com/350x150",
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    CircularProgressIndicator(value: downloadProgress.progress),
                errorWidget: (context, url, error) => Icon(Icons.error, size: 60,),
              ),
            ),
            Text("Editable text with link paypal or stripe"),
          ],
        ),
      ),
    );
  }
}
