import 'package:contacts_app/utils/network.dart';
import 'package:contacts_app/widgets/MyButton.dart';
import 'package:contacts_app/widgets/MyTextField.dart';
import 'package:flutter/material.dart';

class AddEditScreen extends StatefulWidget {
  static TextEditingController nameController = TextEditingController();
  static TextEditingController phoneController = TextEditingController();
  static int id = 0;

  const AddEditScreen({Key? key}) : super(key: key);

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.red,
          title: Text(AddEditScreen.id == 0 ? "مخاطب جدید" : "ویرایش مخاطب"),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextField(
                    controller: AddEditScreen.nameController,
                    errorText: 'لطفا نام و نام خانوادگی را وارد کنید',
                    hintText: "نام و نام خانوادگی",
                    inputType: TextInputType.text),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyTextField(
                    controller: AddEditScreen.phoneController,
                    errorText: 'لطفا شماره تماس را وارد کنید',
                    hintText: "شماره تماس",
                    inputType: TextInputType.number),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyButton(
                    child:
                        Text(AddEditScreen.id == 0 ? "اضافه کردن" : "ویرایش "),
                    width: 350,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {

                        Network.checkInternet();
                        Future.delayed(Duration(seconds: 3)).then((value) {
                          if(Network.isConnected){
                            if (AddEditScreen.id == 0) {
                              Network.postDate(
                                  phone: AddEditScreen.phoneController.text,
                                  fullname: AddEditScreen.nameController.text);
                            } else {
                              Network.putDate(
                                  phone: AddEditScreen.phoneController.text,
                                  fullname: AddEditScreen.nameController.text,
                                  id: AddEditScreen.id.toString());
                            }
                            Navigator.pop(context);
                          }else{
                            Network.showInternetError(context);
                          }
                        });
                        //


                        ///

                      }
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
