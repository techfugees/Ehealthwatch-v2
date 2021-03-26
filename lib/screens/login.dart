import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:techfugeesapp/components/components.dart';
import 'package:techfugeesapp/data/data.dart';
import 'package:techfugeesapp/screens/screens.dart';
import 'package:techfugeesapp/services/modules.dart';
import 'package:techfugeesapp/theme/theme.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController phoneTextController;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  bool islogin = false;
  bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    phoneTextController = TextEditingController();
  }

  void showInSnackBar(String txt) {
    final snackBar = SnackBar(
      content: Text(txt),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void submit(BuildContext context) async {
    final formField = formKey.currentState;
    if (formField.validate()) {
      formField.save();
      setState(() {
        isLoading = true;
      });

      MyNavigator.goToHomePage(context,phoneTextController.text );
    } else {
      setState(() {
        isLoading = false;
      });
      showInSnackBar('Ooooh no! Bad Input!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: maincolor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .2,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "TechFugees",
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                            color: backgroundcolor,
                            fontSize: fontsizexl,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "Tech E-Health App",
                      style: GoogleFonts.raleway(
                        textStyle: TextStyle(
                          color: backgroundcolor,
                          fontSize: fontsize4,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * .1,
                ),
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        // width: MediaQuery.of(context).size.width * 9,
                        height: 40,
                        child: Stack(
                          children: [
                            TextFormField(
                              controller: phoneTextController,
                              keyboardType: TextInputType.phone,
                              obscureText: false,
                              validator: (value) {
                                value = value.trim();
                                if (value.isEmpty) {
                                  return 'Field is required';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'Phone Number',
                                hintStyle: GoogleFonts.getFont(
                                  'Raleway',
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: backgroundcolor,
                                    width: 2,
                                  ),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                ),
                              ),
                              style: GoogleFonts.getFont(
                                'Raleway',
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                            Align(
                              alignment: Alignment(0.95, 0.5),
                              child: Icon(
                                Icons.lock_open,
                                color: Colors.white,
                                size: 24,
                              ),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * .16,
                      ),
                      GestureDetector(
                        onTap: () => submit(context),
                        child: Container(
                          height: 50.00,
                          width: MediaQuery.of(context).size.width * .9,
                          decoration: BoxDecoration(
                            color: backgroundcolor,
                            borderRadius: BorderRadius.circular(5.00),
                          ),
                          child: Center(
                            child: isLoading
                                ? CircularProgressIndicator(
                                    strokeWidth: 2,
                                  )
                                : Text(
                                    "CONTINUE...",
                                    style: GoogleFonts.raleway(
                                        textStyle: TextStyle(
                                            color: maincolor,
                                            fontSize: fontsize,
                                            fontWeight: FontWeight.bold)),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
