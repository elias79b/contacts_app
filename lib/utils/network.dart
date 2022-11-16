import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:contacts_app/models/contact.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Network {
  ////check net
  static bool isConnected = false;
  static Future<bool> checkInternet(BuildContext context) async{
    Connectivity().onConnectivityChanged.listen((status) {
      if(status == ConnectivityResult.mobile || status == ConnectivityResult.wifi){
        isConnected == true;
      }else{
        showInternetError(context);
        isConnected == false;
      }

    });
    return isConnected;
  }
  //////
  static void showInternetError(BuildContext context){
    CoolAlert.show(
        width: 100,
        title: "خطا",
        text: "شما به اینترنت متصل نیستید!!",
        confirmBtnText: "باشه",
        confirmBtnTextStyle: TextStyle(fontSize: 16,color: Colors.white),
        confirmBtnColor: Colors.red,
        context:context,
        type:CoolAlertType.error);
  }
  ////
  static Uri url = Uri.parse('https://retoolapi.dev/lnUCmj/contacts');

  static Uri urlWithId(String id) {
    Uri url = Uri.parse('https://retoolapi.dev/lnUCmj/contacts$id');
    return url;
  }

  //
  static List<Contact> contacts = [];

  /// get date
  static  getDate() async {
    contacts.clear();
    http.get(Network.url).then((response) {
      if (response.statusCode == 200) {
        List jsonDecode = convert.jsonDecode(response.body);
        for (var json in jsonDecode) {
          contacts.add(Contact.fromJson(json));
        }
      }
    });
  }

  ///post
  static void postDate({
    required String phone,
    required String fullname,
  }) async {
    Contact contact = Contact(phone: phone, fullname: fullname);
    http.post(Network.url, body: contact.toJson()).then((response) {
    });
  }

  /// put
  static void putDate({
    required String phone,
    required String fullname,
    required String id,
  }) async {
    Contact contact = Contact(phone: phone, fullname: fullname);
    http.put(urlWithId(id), body: contact.toJson()).then((response) {
    });
  }

  ///delete
  static void deleteContact(String id){
    http.delete(Network.urlWithId(id)).then((value){
      getDate();
    });
  }


}
