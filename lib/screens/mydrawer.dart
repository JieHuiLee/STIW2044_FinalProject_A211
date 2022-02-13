import 'cart_screen.dart';
import 'contactus.dart';
import 'product_screen.dart';
import 'login_screen.dart';
import '/models/user.dart';
import '/models/payment.dart';
import 'recent_payment_screen.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatefulWidget {
  final User user;
  final Payment payment;
  const MyDrawer({Key key, this.user, this.payment}) : super(key: key);
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        UserAccountsDrawerHeader(
          accountEmail: Text(widget.user.email),
          currentAccountPicture: CircleAvatar(
            backgroundColor:
                Theme.of(context).platform == TargetPlatform.android
                    ? Colors.white
                    : Color.fromRGBO(178, 35, 52, 1),
            backgroundImage: AssetImage(
              "assets/images/user.png",
            ),
          ),
          accountName: Text(''),
        ),
        ListTile(
          leading: Icon(
            Icons.home,
            color: Colors.black,
          ),
          title: Text(
            "Home",
            style: TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black),
          ),
        ),
        ListTile(
            leading: Icon(
              Icons.shopping_cart,
              color: Colors.black,
            ),
            title: Text(
              "My Cart",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => CartScreen(
                            user: widget.user,
                          )));
            }),
        ListTile(
            leading: Icon(
              Icons.new_releases,
              color: Colors.black,
            ),
            title: Text(
              "Cuckoo Product",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => ProductScreen(
                            user: widget.user,
                          )));
            }),
        ListTile(
            leading: Icon(
              Icons.payment,
              color: Colors.black,
            ),
            title: Text(
              "My Payment",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => HistoryScreen(
                            user: widget.user,
                          )));
            }),
        ListTile(
            leading: Icon(
              Icons.phone,
              color: Colors.black,
            ),
            title: Text(
              "Contact Us",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(context,
                  MaterialPageRoute(builder: (content) => ContactUs()));
            }),
        ListTile(
            leading: Icon(
              Icons.logout_outlined,
              color: Colors.black,
            ),
            title: Text(
              "Logout",
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black),
            ),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              _logout();
            })
      ],
    ));
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))),
        title: new Text(
          'Do you want to logout?',
          style: TextStyle(),
        ),
        actions: <Widget>[
          MaterialButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (content) => LoginScreen()));
              },
              child: Text(
                "Yes",
                style: TextStyle(),
              )),
          MaterialButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "No",
                style: TextStyle(),
              )),
        ],
      ),
    );
  }
}//end my drawer
