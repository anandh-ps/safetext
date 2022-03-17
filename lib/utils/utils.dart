import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(new MaterialApp(
    home: new Utils(),
  ));
}

class Utils extends StatefulWidget {
  @override
  _AppState createState() => _AppState();

  void onLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
              child: CircularProgressIndicator(
            color: Colors.blue,
          ));
        });
  }

  void showToast(String s) {
    Fluttertoast.showToast(
        msg: s,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void prints(var s1) {
    String s = s1.toString();
    debugPrint(" =======> " + s.toString(), wrapWidth: 1024);
  }

  void bottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
        context: context,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("data"),
                FlatButton(
                  onPressed: () {},
                  child: Text("Cancel"),
                  color: Colors.black87,
                ),
              ],
            ),
          );
        });
  }

  /* Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      return true;
    } else {
      return false;
    }
  }
*/
}

class _AppState extends State<Utils> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("data"),
      ),
      body: Container(
        child: new Text("flutter"),
      ),
    );
  }
}
