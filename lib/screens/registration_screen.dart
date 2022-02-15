import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cuckoo_finalproj/screens/login_screen.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool isObscure = true; //Show Password
  bool _isObscure = true; //View Confirm Password
  // By default, the checkbox is unchecked and "accept" is "false"
  bool accept = false;

  double screenHeight, screenWidth;
  //TextField that allow to enter
  TextEditingController usernameController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();
  TextEditingController confirmpwdController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController otpController = new TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void _clearUsernameTxt() {
    usernameController.clear();
    setState(() {});
  }

  void _clearNameTxt() {
    nameController.clear();
    setState(() {});
  }

  void _clearOtpTxt() {
    otpController.clear();
    setState(() {});
  }

  @override
  void dispose() {
    usernameController.dispose();
    nameController.dispose();
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: 'CUCKOO',
      home: Scaffold(
        backgroundColor: const Color.fromRGBO(217, 217, 217, 1), //#D9D9D9
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 20,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromRGBO(189, 145, 136, 1),
          title: const Text(
            'Registration Page',
            style: TextStyle(
              fontSize: 18,
              fontFamily: 'Open Sans Bold',
              color: Color.fromRGBO(178, 35, 52, 1),
            ),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(children: <Widget>[
              const Text("\nCUCKOO",
                  style: TextStyle(
                      fontSize: 35,
                      fontFamily: 'Open Sans Bold',
                      color: Color.fromRGBO(178, 35, 52, 1),
                      fontWeight: FontWeight.bold)),
              const Text("WATER FILTER",
                  style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'Open Sans Bold',
                      color: Color.fromRGBO(60, 59, 110, 1),
                      fontWeight: FontWeight.bold)),
              const Text("\nSign up for your account\n",
                  style: TextStyle(
                      fontSize: 12,
                      fontFamily: 'Open Sans Bold',
                      color: Color.fromRGBO(60, 59, 110, 1),
                      fontWeight: FontWeight.bold)),
//register card
              Card(
                margin: EdgeInsets.fromLTRB(30, 10, 30, 20),
                elevation: 8,
                shadowColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                      ),
                      Container(
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: usernameController,
                          onChanged: (value) {
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            labelText: 'Set up your username',
                            labelStyle: const TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(189, 145, 136, 1),
                                fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            prefixIcon:
                                const Icon(Icons.supervised_user_circle),
                            suffixIcon: usernameController.text.isEmpty
                                ? null // if the text field is empty
                                : IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: _clearUsernameTxt,
                                  ), // Display clear button if the text field has text
                          ),
                        ),
                        padding: const EdgeInsets.only(
                            left: 4.0, right: 4.0, top: 6.0, bottom: 0),
                      ),
                      Container(
                        width: 300,
                        margin: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.text,
                          controller: nameController,
                          onChanged: (value) {
                            // Call setState to update the UI
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            labelText: 'Your Full Name',
                            labelStyle: const TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(189, 145, 136, 1),
                                fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            prefixIcon: const Icon(Icons.person),
                            suffixIcon: nameController.text.isEmpty
                                ? null // if the text field is empty
                                : IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: _clearNameTxt,
                                  ), // Display clear button if the text field has text
                          ),
                        ),
                        padding: const EdgeInsets.only(
                            left: 4.0, right: 4.0, top: 6.0, bottom: 0),
                      ),
                      Container(
                        width: 300,
                        margin: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          obscureText: isObscure,
                          maxLength: 12,
                          maxLengthEnforced: true,
                          keyboardType: TextInputType.text,
                          controller: pwdController,
                          decoration: InputDecoration(
                            labelText: 'Your password',
                            hintText: '8 - 12 character',
                            hintStyle: const TextStyle(
                              fontSize: 12,
                            ),
                            labelStyle: const TextStyle(
                                fontSize: 11,
                                color: Color.fromRGBO(189, 145, 136, 1),
                                fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            prefixIcon: const Icon(Icons.lock_outline_rounded),
                            suffixIcon: IconButton(
                              icon: Icon(isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off_rounded),
                              onPressed: () {
                                setState(() {
                                  isObscure = !isObscure;
                                });
                              },
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                            left: 4.0, right: 4.0, top: 6, bottom: 6.0),
                      ),
                      Container(
                        width: 300,
                        margin: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          obscureText: _isObscure,
                          keyboardType: TextInputType.text,
                          controller: confirmpwdController,
                          decoration: InputDecoration(
                            labelText: 'Confirm password',
                            hintText: '8 - 12 character',
                            hintStyle: const TextStyle(
                              fontSize: 12,
                            ),
                            labelStyle: const TextStyle(
                                fontSize: 11,
                                color: Color.fromRGBO(189, 145, 136, 1),
                                fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            prefixIcon: const Icon(Icons.password_rounded),
                            suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off_rounded),
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              },
                            ),
                          ),
                        ),
                        padding: const EdgeInsets.only(
                            left: 4.0, right: 4.0, top: 6.0, bottom: 0),
                      ),
                      Container(
                        width: 300,
                        margin: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: emailController,
                          decoration: InputDecoration(
                              hintText: 'email@exp.com',
                              hintStyle: const TextStyle(
                                fontSize: 10,
                              ),
                              labelText: 'Your email',
                              labelStyle: const TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(189, 145, 136, 1),
                                  fontWeight: FontWeight.bold),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              prefixIcon: const Icon(Icons.email),
                              suffixIcon: TextButton(
                                child: const Text("Get OTP"),
                                onPressed: () {},
                              )),
                        ),
                        padding: const EdgeInsets.only(
                            left: 4.0, right: 4.0, top: 6.0, bottom: 0),
                      ),
                      Container(
                        width: 300,
                        margin: const EdgeInsets.only(top: 10),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          controller: otpController,
                          onChanged: (value) {
                            // Call setState to update the UI
                            setState(() {});
                          },
                          decoration: InputDecoration(
                            labelText: 'Enter the OTP',
                            labelStyle: const TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(189, 145, 136, 1),
                                fontWeight: FontWeight.bold),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            prefixIcon:
                                const Icon(Icons.system_security_update_good),
                            suffixIcon: otpController.text.isEmpty
                                ? null // if the text field is empty
                                : IconButton(
                                    icon: const Icon(Icons.clear),
                                    onPressed: _clearOtpTxt,
                                  ), // Display clear button if the text field has text
                          ),
                        ),
                        padding: const EdgeInsets.only(
                            left: 4.0, right: 4.0, top: 6.0, bottom: 0),
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          GestureDetector(
                            child: Text(' * Password format',
                                style: TextStyle(
                                    color: Color.fromRGBO(178, 35, 52, 1),
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold)),
                            onTap: _passwordFormat,
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Checkbox(
                            value: accept,
                            shape: const CircleBorder(),
                            activeColor: const Color.fromRGBO(178, 35, 52, 1),
                            onChanged: _isAccepted,
                          ),
                          const Flexible(
                              child: Text('I accept the ',
                                  style: TextStyle(
                                    fontSize: 10,
                                  ))),
                          GestureDetector(
                              onTap: null,
                              child: const Text(
                                "Terms and Conditions",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.underline,
                                  color: Color.fromRGBO(11, 79, 171, 1),
                                ),
                              )),
                        ],
                      ),
                      //Sign Up Button
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: accept ? _register : null,
                              style: ElevatedButton.styleFrom(
                                primary: const Color.fromRGBO(178, 35, 52, 1),
                                onPrimary: Colors.white,
                                onSurface: Colors.grey[800], // Disable color
                              ),
                              child: Text(
                                "Sign Up".toUpperCase(),
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text('Already have an account? ',
                      style: TextStyle(fontSize: 15)),
                  Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(11, 79, 171, 1),
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ]),
                onTap: _alreadyReg,
              ),
              SizedBox(height: 15),
              const Text(
                "YOUR SAFETY IS OUR NO.1\n",
                style: TextStyle(
                    fontSize: 10,
                    color: Color.fromRGBO(60, 59, 110, 1),
                    fontWeight: FontWeight.bold),
              ),
            ]),
          ),
        ),
      ),
    );
  }

  void _alreadyReg() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  void _register() {
    String username = usernameController.text.toString();
    String name = nameController.text.toString();
    String pwd = pwdController.text.toString();
    String confPassword = confirmpwdController.text.toString();
    String email = emailController.text.toString();
    String otp = otpController.text.toString();
    if (username.isEmpty ||
        name.isEmpty ||
        pwd.isEmpty ||
        confPassword.isEmpty ||
        email.isEmpty ||
        otp.isEmpty) {
      showToast(1);
      return;
    }
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Text("Register "),
            content: new Container(
              height: 40,
              child: Text("Are you sure you want to register ?"),
            ),
            actions: [
              TextButton(
                  child: Text("Confirm",
                      style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _checkEmailPassword(email, pwd, confPassword);
                  }),
              TextButton(
                  child: Text("Cancel",
                      style: TextStyle(
                          color: Colors.greenAccent,
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  void _registerUser(String email, String password) {
    http.post(
        Uri.parse(
            "https://fluttermycuckoodb.000webhostapp.com/php/register_user.php"),
        body: {"email": email, "password": password}).then((response) {
      print(response.body);
      if (response.body == "success") {
        showToast(2);
      } else {
        showToast(3);
      }
    });
  }

  void _checkEmailPassword(String email, String password, String confPassword) {
    if (password != confPassword) {
      showToast(4);
      return;
    } else {
      if (RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                  .hasMatch(email) ==
              true &&
          RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,10}$')
                  .hasMatch(password) ==
              true) {
        showToast(2);
        _registerUser(email, password);
        return;
      } else {
        showToast(0);
      }
    }
  }

  void showToast(int num) {
    switch (num) {
      case 1:
        Fluttertoast.showToast(
            msg: "Please fill all the required text field.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromRGBO(189, 145, 136, 1), //#BD9188
            textColor: Colors.black,
            fontSize: 16);
        break;
      case 2:
        Fluttertoast.showToast(
            msg: "Register Success. Please check your email.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromRGBO(189, 145, 136, 1), //#BD9188
            textColor: Colors.black,
            fontSize: 16);
        break;
      case 3:
        Fluttertoast.showToast(
            msg: "Cannot register using the same email",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromRGBO(189, 145, 136, 1), //#BD9188
            textColor: Colors.black,
            fontSize: 16);
        break;
      case 4:
        Fluttertoast.showToast(
            msg:
                "Please enter the same password", //Confirm Password must same with Password entered
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromRGBO(189, 145, 136, 1), //#BD9188
            textColor: Colors.black,
            fontSize: 16);
        break;

      default:
        Fluttertoast.showToast(
            msg: "Please enter correct email or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromRGBO(189, 145, 136, 1), //#BD9188
            textColor: Colors.black,
            fontSize: 16);
    }
  }

  void _isAccepted(bool newValue) => setState(() {
        accept = newValue;
        if (accept) {
          // moveaccept(true);
        } else {
          //moveaccept(false);
        }
      });

  void _passwordFormat() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            title: Text("Password Format "),
            content: new Container(
              height: 100,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text(
                        '- Minimum 1 upper case\n' +
                            '- Minimum 1 lower case\n' +
                            '- Minimum 1 numeric case\n' +
                            '- Minimum 1 special case',
                        style: TextStyle(fontSize: 15),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: TextButton(
                    child: Text("OK",
                        style: TextStyle(
                            color: const Color.fromRGBO(
                                189, 145, 136, 1), //#BD9188
                            fontWeight: FontWeight.bold)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
              ),
            ],
          );
        });
  }
}
