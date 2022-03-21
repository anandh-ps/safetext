import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safetext/components/dashboardScreen.dart';
import 'package:safetext/utils/responsive.dart';
import 'package:safetext/utils/utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home: LoginScreen(),
      initialRoute: '/login',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/login': (context) => const LoginScreen(),
        // When navigating to the "/second" route, build the SecondScreen widget.
      },
    ),
  );
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Utils util = new Utils();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(
                  "https://images.unsplash.com/reserve/bOvf94dPRxWu0u3QsPjF_tree.jpg?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=876&q=80"),
              fit: BoxFit.cover,
            ),
          ),
          child: Responsive.isDesktop(context)
              ? desktop()
              : Responsive.isTablet(context)
                  ? tablet()
                  : mobile()),
    );
  }

  Widget desktop() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              height: MediaQuery.of(context).size.height * 0.5,
              width: MediaQuery.of(context).size.width * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  usernamepass("Name", false, usernameController),
                  usernamepass("Password", false, passwordController),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      util.onLoading(context);
                      final QuerySnapshot result = await FirebaseFirestore
                          .instance
                          .collection(usernameController.text)
                          .get();
                      final List<DocumentSnapshot> documents = result.docs;
                      try {
                        DocumentSnapshot kjnk = documents[1];
                        print(kjnk.id);
                        print(kjnk[kjnk.id]);
                        if (kjnk[kjnk.id] == passwordController.text) {
                          util.showToast("Success");
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashBoardScreen(
                                      collectionController:
                                          usernameController)));
                        } else {
                          util.showToast("Please Enter the correct Password");
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => new AlertDialog(
                                  title: new Text(
                                      'There is no user registered with this username'),
                                  content: new Text(
                                      'Do you want to create new Acoount'),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () async {
                                            Utils util = new Utils();
                                            util.onLoading(context);
                                            FirebaseFirestore.instance
                                                .collection(
                                                    usernameController.text)
                                                .doc("Content")
                                                .set({
                                              "Sample":
                                                  "Save Your Data before moving another Tab!",
                                            });
                                            FirebaseFirestore.instance
                                                .collection(
                                                    usernameController.text)
                                                .doc("password")
                                                .set({
                                              "password":
                                                  passwordController.text
                                            });

                                            Navigator.pop(context);
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DashBoardScreen(
                                                            collectionController:
                                                                usernameController)));
                                          },
                                          child: new Text('Yes'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: new Text('No'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ));
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget tablet() {
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              height: MediaQuery.of(context).size.height,
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  usernamepass("Name", false, usernameController),
                  usernamepass("Password", false, passwordController),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () async {
                      util.onLoading(context);
                      final QuerySnapshot result = await FirebaseFirestore
                          .instance
                          .collection(usernameController.text)
                          .get();
                      final List<DocumentSnapshot> documents = result.docs;
                      try {
                        DocumentSnapshot kjnk = documents[1];
                        print(kjnk.id);
                        print(kjnk[kjnk.id]);
                        if (kjnk[kjnk.id] == passwordController.text) {
                          util.showToast("Success");
                          Navigator.pushNamed(context, "/second");
                        } else {
                          util.showToast("Please Enter the correct Password");
                          Navigator.pop(context);
                        }
                      } catch (e) {
                        Navigator.pop(context);
                        showDialog(
                            context: context,
                            builder: (context) => new AlertDialog(
                                  title: new Text(
                                      'There is no user registered with this username'),
                                  content: new Text(
                                      'Do you want to create new Acoount'),
                                  actions: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Utils util = new Utils();
                                            util.onLoading(context);
                                          },
                                          child: new Text('Yes'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: new Text('No'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ));
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          "Login",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget mobile() {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                usernamepass("Name", false, usernameController),
                usernamepass("Password", false, passwordController),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () async {
                    util.onLoading(context);
                    final QuerySnapshot result = await FirebaseFirestore
                        .instance
                        .collection(usernameController.text)
                        .get();
                    final List<DocumentSnapshot> documents = result.docs;
                    try {
                      DocumentSnapshot kjnk = documents[1];
                      print(kjnk.id);
                      print(kjnk[kjnk.id]);
                      if (kjnk[kjnk.id] == passwordController.text) {
                        util.showToast("Success");
                        Navigator.pushNamed(context, "/second");
                      } else {
                        util.showToast("Please Enter the correct Password");
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      Navigator.pop(context);
                      showDialog(
                          context: context,
                          builder: (context) => new AlertDialog(
                                title: new Text(
                                    'There is no user registered with this username'),
                                content: new Text(
                                    'Do you want to create new Acoount'),
                                actions: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Utils util = new Utils();
                                          util.onLoading(context);
                                        },
                                        child: new Text('Yes'),
                                      ),
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: new Text('No'),
                                      ),
                                    ],
                                  ),
                                ],
                              ));
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: Text(
                        "Login",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget usernamepass(String usernamepass, bool obsecuretext,
      TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(usernamepass,
              style: TextStyle(fontSize: 18, color: Color(0xff383a3e))),
        ),
        Container(
          margin: EdgeInsets.all(5),
          child: TextFormField(
            controller: controller,
            obscureText: obsecuretext,
            autocorrect: true,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: usernamepass,
              hintStyle: TextStyle(color: Colors.grey),
              filled: true,
              contentPadding: EdgeInsets.only(bottom: 0.0, left: 8.0),
              fillColor: Colors.white70,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Color(0xFF97E360), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Color(0xFF97E360)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
