// import 'dart:convert';
// import 'dart:io';
//
// import 'package:contacts_app/screens/home_screen.dart';
// import 'package:contacts_app/utils/network.dart';
// import 'package:contacts_app/widgets/MyButton.dart';
// import '../../../Financial_Management/lib/widget/MyTextField.dart';
// import 'package:cool_alert/cool_alert.dart';
// import 'package:crypto/crypto.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class LicenseScreen extends StatelessWidget {
//   LicenseScreen({Key? key}) : super(key: key);
//
//   Future<String?> getDeviceId() async {
//     var deviceInfo = DeviceInfoPlugin();
//     if (Platform.isIOS) {
//       var iosdiviceInfo = await deviceInfo.iosInfo;
//       return iosdiviceInfo.identifierForVendor;
//     } else {
//       var androidDeviceInfo = await deviceInfo.androidInfo;
//       return androidDeviceInfo.id;
//     }
//   }
//
//   void showSuccessDialog(BuildContext context) {
//     CoolAlert.show(
//         width: 100,
//         context: context,
//         type: CoolAlertType.success,
//         title: "موفق",
//         text: "کد با موفقیت کپی شد",
//         cancelBtnText: "باشه",
//         confirmBtnTextStyle: TextStyle(fontSize: 16, color: Colors.white),
//         confirmBtnColor: Colors.red);
//   }
//
//   final TextEditingController systemCodeController = TextEditingController();
//   final TextEditingController activeCodeController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     getDeviceId().then((value) {
//       systemCodeController.text = value ?? '';
//     });
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.red,
//         title: Text('فعال سازی'),
//         centerTitle: true,
//         leading: Icon(Icons.import_contacts_sharp),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           children: [
//             GestureDetector(
//               onTap: (){
//                 Clipboard.setData(ClipboardData(text: systemCodeController.text));
//                 showSuccessDialog(context);
//               },
//                 child: MyTextField(
//                     errorText: '',
//                     controller: systemCodeController,
//                     hintText: 'کد سیستم',
//                     inputType: TextInputType.text,
//                     isEnabled: false)),
//             MyTextField(
//               errorText: '',
//               controller: activeCodeController,
//               hintText: 'کد فعال سازی',
//               inputType: TextInputType.text,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             MyButton(
//               width: 220,
//               child: Text("فعال سازی"),
//               onPressed: () {
//                 var bytes1 = utf8.encode(systemCodeController.text);
//                 var diges1 = sha512256.convert(bytes1);
//                 if(activeCodeController.text == diges1){
//                   Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
//                 }
//               },
//               color: Colors.red,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
