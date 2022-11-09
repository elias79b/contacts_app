import 'package:contacts_app/screens/add_edit_screen.dart';
import 'package:contacts_app/utils/network.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Network.checkInternet();
    Future.delayed(Duration(seconds: 3)).then((value) {
      if (Network.isConnected) {
        Network.getDate().then((value) async {
          await Future.delayed(Duration(seconds: 3));
          setState(() {});
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AddEditScreen.id = 0;
          AddEditScreen.phoneController.text = '';
          AddEditScreen.nameController.text = '';
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AddEditScreen()))
              .then((value) async {
            Network.getDate().then((value) async {
              await Future.delayed(const Duration(seconds: 5));
              setState(() {});
            });
          });
        },
        backgroundColor: Colors.red,
        elevation: 0,
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.red,
        title: Text('دفترچه تلفن آنلاین'),
        centerTitle: true,
        leading: Icon(Icons.import_contacts_sharp),
        actions: [
          IconButton(
              onPressed: () {
                Network.getDate().then((value) async {
                  await Future.delayed(const Duration(seconds: 3));
                  setState(() {});
                });
              },
              icon: Icon(Icons.refresh))
        ],
      ),
      body: ListView.builder(
          itemCount: Network.contacts.length,
          itemBuilder: (context, index) {
            return ListTile(
              onLongPress: () async {
                Network.deleteContact(Network.contacts[index].id.toString());
                await Future.delayed(Duration(seconds: 3));
                setState(() {});
              },
              leading: CircleAvatar(
                backgroundColor: Colors.red,
                child: Text(
                  (index + 1).toString(),
                  style: TextStyle(color: Colors.white),
                ),
              ),
              trailing: IconButton(
                  onPressed: () {
                    AddEditScreen.id = Network.contacts[index].id;
                    AddEditScreen.phoneController.text =
                        Network.contacts[index].phone;
                    AddEditScreen.nameController.text =
                        Network.contacts[index].fullname;
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddEditScreen()))
                        .then((value) async {
                      Network.checkInternet();
                      Future.delayed(Duration(seconds: 3)).then((value) {
                        if (Network.isConnected) {
                          Network.getDate().then((value) async {
                            await Future.delayed(Duration(seconds: 3));
                            setState(() {});
                          });
                        } else {
                          Network.showInternetError(context);
                        }
                      });
                    });
                  },
                  icon: Icon(Icons.edit)),
              title: Text(Network.contacts[index].fullname),
              subtitle: Text(Network.contacts[index].phone),
            );
          }),
    );
  }
}
