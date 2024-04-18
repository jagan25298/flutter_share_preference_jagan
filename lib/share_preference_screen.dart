import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrencePractice extends StatefulWidget {
  const SharedPrefrencePractice({super.key});

  @override
  State<SharedPrefrencePractice> createState() =>
      _SharedPrefrencePracticeState();
}

class _SharedPrefrencePracticeState extends State<SharedPrefrencePractice> {
  var nameController = TextEditingController();
  String usernName = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadValues();
    print('initstate');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyanAccent,
        title: Text('Share Preferences'),),
      body: SafeArea(
        child: ListTile(
          title: Text(usernName),
          leading: IconButton(
              onPressed: () {
                showTextDialog();
              },
              icon: Icon(Icons.edit)),
        ),
      ),
    );
  }

  showTextDialog() {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: TextFormField(
            controller: nameController,
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  saveData('personName', nameController.text);
                  loadValues();
                  print('saved name clicked');
                  Navigator.pop(context);
                },
                child: Text("save")),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  print('cancel button clicked');
                },
                child: Text("cancel"))
          ],
        );
      },
    );
  }

  saveData(String key, String value) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(key, value);
  }

  getData(String key) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  loadValues() async {
    final savedName = await getData('personName');
    setState(() {
      usernName = savedName;
    });
  }
}
