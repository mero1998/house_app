// import 'package:flutter/material.dart';
//
// class TextFiledApp extends StatelessWidget {
//
//   final TextInputType;
//   final TextEditingController controller;
//   final String hintText;
//   final suffixIcon
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       keyboardType: TextInputType.emailAddress,
//       style: TextStyle(color: Colors.black),
//       decoration: InputDecoration(
//         enabledBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: Colors.grey),
//         ),
//         focusedBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: Colors.grey),
//         ),
//         border: UnderlineInputBorder(
//           borderSide: BorderSide(color: Colors.grey),
//         ),
//         contentPadding: EdgeInsets.only(top: 20),
//         isDense: true,
//         hintText: "Your Email",
//         hintStyle: TextStyle(color: Colors.grey, fontSize: 12),
//         prefixIcon: Padding(
//           padding: EdgeInsets.only(top: 15), // add padding to adjust icon
//           child: Icon(
//             Icons.mail,
//             color: mainColor,
//           ),
//         ),
//       ),
//       controller: controller.emailController,
//       onSaved: (value) {
//         controller.email = value!;
//       },
//       validator: (value) {
//         return controller.validateEmail(value!);
//       },
//     );;
//   }
// }
