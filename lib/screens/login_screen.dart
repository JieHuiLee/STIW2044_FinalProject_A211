import '/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cuckoo_finalproj/screens/main_screen.dart';
import 'package:cuckoo_finalproj/screens/registration_screen.dart';

class LoginScreen extends StatefulWidget {
  final User user;

  const LoginScreen({Key key, this.user}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscure = true; //Show Password
  bool _rememberMe = false;
  SharedPreferences sharedPref;
  //TextField that allow to enter
  TextEditingController emailController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();
  @override
  void initState() {
    loadPreference();
    super.initState();
  }

  void _clearTextField() {
    // Clear all in the text field
    emailController.clear();
    setState(() {});
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
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
          Container(
            width: 120,
            child: Image.asset(
              'assets/images/loginIcon.png',
            ),
          ),
          Card(
            elevation: 8,
            color: const Color.fromRGBO(217, 217, 217, 1), //#D9D9D9
            margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
            shadowColor: Colors.grey,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
              child: Column(
                children: [
                  Container(
                    //Email field
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      onChanged: (value) {
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        labelText: 'Enter your email',
                        hintText: 'youremail@exp.com',
                        hintStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        labelStyle: const TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(189, 145, 136, 1),
                            fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: const Icon(Icons.email),
                        suffixIcon: emailController.text.isEmpty
                            ? null // if the text field is null
                            : IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: _clearTextField,
                              ), // Display clear button if the text field has text
                      ),
                    ),
                  ),
                  Container(
                    width: 250,
                    margin: const EdgeInsets.only(top: 10),
                    //Password field
                    child: TextFormField(
                      obscureText: _isObscure,
                      keyboardType: TextInputType.text,
                      controller: pwdController,
                      decoration: InputDecoration(
                        labelText: 'Enter password',
                        hintText: '8 - 12 character',
                        hintStyle: const TextStyle(
                          fontSize: 14,
                        ),
                        labelStyle: const TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(189, 145, 136, 1),
                            fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        prefixIcon: const Icon(Icons.lock_outline_rounded),
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
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: _rememberMe,
                          activeColor: const Color.fromRGBO(178, 35, 52, 1),
                          onChanged: (bool value) {
                            _onChange(value);
                          }),
                      Text("Remember me\t\t\t"),
                      //Reset password
                      GestureDetector(
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                            color: Color.fromRGBO(11, 79, 171, 1),
                          ),
                        ),
                        onTap: _forgotPassword,
                      ),
                    ],
                  ),
                  //Login button
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        ElevatedButton(
                          onPressed: _rememberMe ? _login : null,
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(178, 35, 52, 1),
                            onPrimary: Colors.white,
                            onSurface: Colors.grey[800], // Disable color
                          ),
                          child: Text(
                            "Login".toUpperCase(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        //Login As Guest (Without email and password)
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainScreen(user: widget.user)));
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromRGBO(178, 35, 52, 1),
                            onPrimary: Colors.white,
                            onSurface: Colors.grey[800], // Disable color
                          ),
                          child: Text(
                            "Login As Guest".toUpperCase(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ]),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text("Don't have an account? ",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color.fromRGBO(60, 59, 110, 1),
                  )),
              GestureDetector(
                  onTap: _regNewUser,
                  child: const Text(
                    " Sign Up",
                    style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                      color: Color.fromRGBO(11, 79, 171, 1),
                    ),
                  )),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            "YOUR SAFETY IS OUR NO.1\n",
            style: TextStyle(
                fontSize: 10,
                color: Color.fromRGBO(60, 59, 110, 1),
                fontWeight: FontWeight.bold),
          ),
        ]),
      )),
    ));
  }

  void _onChange(bool value) {
    String email = emailController.text.toString();
    String pwd = pwdController.text.toString();
    if (email.isEmpty || pwd.isEmpty) {
      showToast(1);
      return;
    }
    setState(() {
      _rememberMe = value;
      savePreference(value, email, pwd);
    });
  }

  Future<void> savePreference(bool value, String email, String password) async {
    sharedPref = await SharedPreferences.getInstance();
    if (value) {
      await sharedPref.setString("email", email);
      await sharedPref.setString("password", password);
      await sharedPref.setBool("rememberMe", value);
      Fluttertoast.showToast(
        msg: "Your email and password is saved",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: const Color.fromRGBO(189, 145, 136, 1), //#BD9188
        textColor: Colors.black,
        fontSize: 15,
      );
      return;
    } else {
      await sharedPref.setString("email", '');
      await sharedPref.setString("password", '');
      await sharedPref.setBool("rememberMe", value);
      Fluttertoast.showToast(
        msg: "Preference removed",
        timeInSecForIosWeb: 1,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: const Color.fromRGBO(189, 145, 136, 1), //#BD9188
        textColor: Colors.black,
        fontSize: 15,
      );
      setState(() {
        emailController.text = "";
        pwdController.text = "";
        _rememberMe = false;
      });
      return;
    }
  }

  Future<void> loadPreference() async {
    sharedPref = await SharedPreferences.getInstance();
    String email = sharedPref.getString("email") ?? '';
    String pwd = sharedPref.getString("password") ?? '';
    _rememberMe = sharedPref.getBool("rememberMe") ?? false;

    setState(() {
      emailController.text = email;
      pwdController.text = pwd;
    });
  }

  void _regNewUser() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
  }

  void _forgotPassword() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: new Container(
              height: 80,
              child: Column(
                children: [
                  Text("Reset your password ?"),
                  TextField(
                      decoration: InputDecoration(
                          labelText: 'Email',
                          hintText: 'Enter your recovery email',
                          hintStyle: const TextStyle(
                            fontSize: 12,
                          ),
                          icon: Icon(Icons.email, size: 18))),
                ],
              ),
            ),
            actions: [
              TextButton(
                  child: Text("Submit",
                      style: TextStyle(
                          color: Color.fromRGBO(178, 35, 52, 1),
                          fontWeight: FontWeight.bold)),
                  onPressed: () {
                    print(emailController.text);
                    _resetPassword(emailController.text);
                  }),
              TextButton(
                  child: Text("Cancel"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ],
          );
        });
  }

  void _login() {
    String email = emailController.text.toString();
    String pwd = pwdController.text.toString();
    _checkEmailPassword(email, pwd);
  }

  void _checkEmailPassword(String email, String password) {
    if (email.isEmpty == true || password.isEmpty == true) {
      showToast(1);
    } else {
      if (RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                  .hasMatch(email) ==
              true &&
          RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,10}$')
                  .hasMatch(password) ==
              true) {
        http.post(
            Uri.parse(
                "https://fluttermycuckoodb.000webhostapp.com/php/login_user.php"),
            body: {"email": email, "password": password}).then((response) {
          print(response.body);
          if (response.body == "failed") {
            showToast(3);
          } else {
            showToast(2);
            User user = User(
              email: email,
              password: password,
            );
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MainScreen(user: user)));
          }
        });
      } else {
        showToast(0);
      }
    }
  }

  void showToast(int num) {
    switch (num) {
      case 1:
        Fluttertoast.showToast(
            msg: "Please enter your email or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromRGBO(189, 145, 136, 1), //#BD9188
            textColor: Colors.black,
            fontSize: 15);
        break;
      case 2:
        Fluttertoast.showToast(
            msg: "Login Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromRGBO(189, 145, 136, 1), //#BD9188
            textColor: Colors.black,
            fontSize: 15);

        break;
      case 3:
        Fluttertoast.showToast(
            msg: "Login Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromRGBO(189, 145, 136, 1), //#BD9188
            textColor: Colors.black,
            fontSize: 15);
        break;
      default:
        Fluttertoast.showToast(
            msg: "Please enter correct email or password",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromRGBO(189, 145, 136, 1), //#BD9188
            textColor: Colors.black,
            fontSize: 15);
    }
  }

  void _resetPassword(String email) {
    http.post(
        Uri.parse(
            "https://fluttermycuckoodb.000webhostapp.com/php/reset_password.php"),
        body: {"email": email}).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromRGBO(189, 145, 136, 1), //#BD9188
            textColor: Colors.black,
            fontSize: 15);
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: const Color.fromRGBO(189, 145, 136, 1), //#BD9188
            textColor: Colors.black,
            fontSize: 15);
      }
    });
  }
}
