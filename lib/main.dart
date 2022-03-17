import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safetext/utils/utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      home: LoginScreen(),
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            usernamepass("Name", false, usernameController),
            usernamepass("Password", true, passwordController),
            InkWell(
              onTap: () async {
                final QuerySnapshot result = await FirebaseFirestore.instance
                    .collection(usernameController.text)
                    .get();
                final List<DocumentSnapshot> documents = result.docs;
                DocumentSnapshot kjnk = documents[1];
                print(kjnk.id);
                print(kjnk[kjnk.id]);
                if (kjnk[kjnk.id] == passwordController.text) {
                  util.showToast("Success");
                }
                // FirebaseFirestore.instance
                //     .collection(usernameController.text)
                //     .doc("password")
                //     .set({"password": passwordController.text});
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
              style: TextStyle(fontSize: 18, color: Color(0xff123456))),
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
                borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Colors.lightBlueAccent),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
