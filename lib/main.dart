import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:safetext/utils/utils.dart';
import 'components/side_menu.dart';
import 'dart:convert';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home: LoginScreen(),
    ),
  );
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreen createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  var allData;
  String title = "";
  bool flag = true;
  TextEditingController saveController = TextEditingController();

  @override
  void initState() {
    main();
    super.initState();
  }

  int selectedId = 0;

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    getTokenId();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 850;
    bool isTablet = MediaQuery.of(context).size.width < 1100 &&
        MediaQuery.of(context).size.width >= 850;
    bool isDesktop = MediaQuery.of(context).size.width >= 1100;
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();
    double margin = 14;
    int gridCount = 2;
    if (isTablet) {
      margin = 100;
      gridCount = 7;
    } else if (MediaQuery.of(context).size.width > 500 &&
        isTablet == false &&
        isDesktop == false) {
      margin = 70;
      gridCount = 3;
    } else if (isDesktop) {
      gridCount = 8;
      margin = 100;
    }
    Utils util = new Utils();
    TextEditingController titleController = TextEditingController();
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color(0xFFebf0fa),
          key: _scaffoldKey,
          appBar: AppBar(
            automaticallyImplyLeading:
                false, // this will hide Drawer hamburger icon

            title: Text(
              "Salezrobot",
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: 'HelveticaNeue',
              ),
            ),
            actions: <Widget>[
              InkWell(
                onTap: () {
                  print("download");
                },
                child: Container(
                  margin: EdgeInsets.all(12),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        Icons.download_rounded,
                        color: Colors.black,
                        size: 22,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Download",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: 'HelveticaNeue',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Utils util = new Utils();
                  util.onLoading(context);
                  int index = 0;
                  FirebaseFirestore.instance
                      .collection('anand')
                      .doc('0Nx01x3HgeswCn6KSNa9')
                      .update({
                    title: saveController.text,
                  });
                  print("==" + title);
                  print(saveController.text);

                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.all(12),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        Icons.save,
                        color: Colors.black,
                        size: 22,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "Save",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: 'HelveticaNeue',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  dialogbox();
                },
                child: Container(
                  margin: EdgeInsets.all(12),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.white,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Icon(
                          Icons.create_new_folder,
                          color: Colors.black,
                          size: 22,
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        "New File",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontFamily: 'HelveticaNeue',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isTablet || isDesktop) ...[
                SizedBox(width: 32),
                Container(
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                SizedBox(width: 32),
              ],
              if (isMobile == true) ...[
                Container(
                  child: IconButton(
                    padding: EdgeInsets.all(0),
                    icon: Icon(Icons.more_vert),
                    onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
                  ),
                ),
              ],
            ],
            backgroundColor: Colors.blue,
            // automaticallyImplyLeading: false,
          ),
          body: Container(
            margin: EdgeInsets.only(left: margin, right: margin),
            child: Column(
              children: [
                if (allData == null) ...[
                  Text("Loading..."),
                ],
                if (allData != null) ...[
                  GridView.count(
                    crossAxisCount: gridCount,
                    childAspectRatio: (.5 / .10),
                    shrinkWrap: true,
                    children: List.generate(allData.length, (index) {
                      Map<String, dynamic> allDatas = allData;
                      String s = allDatas.keys.elementAt(index);
                      if (flag == true) {
                        saveController.text =
                            json.encode(allDatas[s].toString());
                        flag = false;
                      }

                      List<Color> colors;
                      if (selectedId != index) {
                        colors = [Color(0xFF9796f0), const Color(0xFFfbc7d4)];
                      } else {
                        colors = [Color(0xFFffffff), const Color(0xFFffffff)];
                      }

                      return Padding(
                        padding:
                            const EdgeInsets.only(right: 2, left: 1, top: 4),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: colors,
                                begin: const FractionalOffset(0.0, 0.0),
                                end: const FractionalOffset(1.0, 0.0),
                                stops: [0.0, 1.0],
                                tileMode: TileMode.clamp),
                            color: Colors.white,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(6),
                              topRight: Radius.circular(6),
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                title = s;
                                // print("======== " + s);
                                // util.prints(allDatas[s]);
                                selectedId = index;
                                saveController.text =
                                    json.encode(allDatas[s].toString());
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("  " + s),
                                InkWell(
                                  onTap: () {
                                    FirebaseFirestore.instance
                                        .collection('anand')
                                        .doc('0Nx01x3HgeswCn6KSNa9')
                                        .update({
                                      s: FieldValue.delete(),
                                    });
                                    // Navigator.pop(context);
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             LoginScreen()));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(top: 2, right: 4),
                                    child: Icon(
                                      Icons.close,
                                      size: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ],
                Container(
                  constraints: BoxConstraints(maxHeight: 500),
                  child: SingleChildScrollView(
                    child: TextFormField(
                      controller: saveController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(10.0),
                        hintText: "Your text goes here...",
                        hintStyle: TextStyle(color: Colors.grey),
                        filled: true,
                        fillColor: Colors.white,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          borderSide: BorderSide(color: Colors.grey, width: 1),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                      minLines: 50,
                      // any number you need (It works as the rows for the textarea)
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  dialogbox() {
    TextEditingController controller = TextEditingController();
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Add File Name'),
        content: new Text('Please Enter the file name'),
        actions: <Widget>[
          TextFormField(
            controller: controller,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton(
                onPressed: () {
                  Utils util = new Utils();
                  util.onLoading(context);

                  FirebaseFirestore.instance
                      .collection('anand')
                      .doc('0Nx01x3HgeswCn6KSNa9')
                      .update({
                    controller.text: "",
                  });
                  String empty = "";
                  Map<String, dynamic> newData = new Map();
                  allData.addAll({controller.text: empty});
                  setState(() {});
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: new Text('Add'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: new Text('Cancel'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> getTokenId() async {
    var firestore = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await firestore.collection("anand").get();
    for (var snapshot in querySnapshot.docs) {
      var documentID = snapshot.id; // <-- Document ID
      print(documentID);
    }
/*
    final allData = querySnapshot.docs.map((doc) => doc.get('name')).toList();
*/
    setState(() {
      allData = querySnapshot.docs.map((doc) => doc.data()).toList()[0];
    });
    print(allData);
  }
}
