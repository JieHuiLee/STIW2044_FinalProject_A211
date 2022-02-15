import 'mydrawer.dart';
import 'cart_screen.dart';
import 'addproduct_screen.dart';
import '/models/user.dart';
import '/models/payment.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class MainScreen extends StatefulWidget {
  final User user;
  final Payment payment;
  MainScreen({Key key, this.user, this.payment}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List _productList = [];
  String titleCenter = "Loading...";
  double screenHeight, screenWidth;
  int cartitem = 0;
  SharedPreferences prefs;
  String email = "";
  TextEditingController _srcController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _testasync();
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(189, 145, 136, 1),
        title: Text(
          'Home',
          style: TextStyle(
            color: Color.fromRGBO(178, 35, 52, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton.icon(
              onPressed: () => {_goCart()},
              icon: Icon(
                Icons.shopping_cart,
                color: Colors.black,
              ),
              label: Text(
                cartitem.toString(),
                style: TextStyle(color: Colors.black),
              )),
        ],
      ),
      drawer: MyDrawer(user: widget.user, payment: widget.payment),
      body: Center(
        child: Column(
          children: [
            Container(
                width: 250,
                height: 75,
                padding: EdgeInsets.fromLTRB(0, 15, 0, 0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _srcController,
                      decoration: InputDecoration(
                        hintText: "Search product",
                        suffixIcon: IconButton(
                          onPressed: () => _loadProducts(_srcController.text),
                          icon: Icon(Icons.search),
                        ),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white24)),
                      ),
                    ),
                  ],
                )),
            if (_productList.isEmpty)
              Flexible(child: Center(child: Text('Loading Products...')))
            else
              Flexible(
                  child: OrientationBuilder(builder: (context, orientation) {
                return StaggeredGridView.countBuilder(
                    padding: EdgeInsets.all(10),
                    crossAxisCount: orientation == Orientation.portrait ? 2 : 4,
                    itemCount: _productList.length,
                    staggeredTileBuilder: (int index) =>
                        new StaggeredTile.fit(1),
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 4.0,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Column(
                        children: [
                          Container(
                            child: Card(
                              elevation: 10,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height:
                                          orientation == Orientation.portrait
                                              ? 100
                                              : 150,
                                      width: orientation == Orientation.portrait
                                          ? 100
                                          : 150,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "https://fluttermycuckoodb.000webhostapp.com/images/" +
                                                _productList[index]['prid'] +
                                                "_1.png",
                                        height: 300,
                                        width: 300,
                                      ),
                                    ),
                                    Text(
                                      titleSub(
                                        'Cuckoo',
                                      ),
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text('Water Filter'),
                                    Text("RM " + "3200"),
                                    Text("Qty: " + '7'),
                                    Container(
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary: const Color.fromRGBO(
                                              178, 35, 52, 1),
                                        ),
                                        onPressed: () => {_addToCart(index)},
                                        child: AutoSizeText('Add to Cart',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.white),
                                            minFontSize: 1,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    });
              })),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        backgroundColor: Color.fromRGBO(178, 35, 52, 1),
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: "New Product",
            labelStyle: const TextStyle(color: Colors.black),
            labelBackgroundColor: Colors.white,
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) =>
                          NewProduct(user: widget.user)))
            },
          ),
        ],
      ),
    );
  }

  _loadProducts(String prname) {
    http.post(
        Uri.parse(
            "https://fluttermycuckoodb.000webhostapp.com/php/load_products.php"),
        body: {"prname": prname}).then((response) {
      if (response.body != "nodata") {
        var jsondata = json.decode(response.body);
        _productList = jsondata["products"];
        print("Success");
        setState(() {});
      } else {
        print("Failed");
        return;
      }
    });
  }

  _goCart() async {
    if (email == "") {
      Fluttertoast.showToast(
          msg: "Please set your email first",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.greenAccent,
          textColor: Colors.black,
          fontSize: 16.0);
      _loademaildialog();
    } else {
      await Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => CartScreen(email: email, user: widget.user),
        ),
      );
      _loadProducts("all");
    }
  }

  _addToCart(int index) {
    if (email == '') {
      _loademaildialog();
    } else {
      String prid = _productList[index]['prid'];
      http.post(
          Uri.parse(
              "https://fluttermycuckoodb.000webhostapp.com/php/insert_cart.php"),
          body: {"email": widget.user.email, "prid": prid}).then((response) {
        print(response.body);
        if (response.body == "failed") {
          Fluttertoast.showToast(
              msg: "Failed",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.black87,
              fontSize: 16.0);
        } else {
          Fluttertoast.showToast(
              msg: "Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.greenAccent,
              textColor: Colors.black87,
              fontSize: 16.0);
          //  _loadCart();
        }
      });
    }
  }

  String titleSub(String title) {
    if (title.length > 15) {
      return title.substring(0, 15) + "...";
    } else {
      return title;
    }
  }

  Future<void> _testasync() async {
    await _loadPref();
    _loadProducts("all");
    //_loadCart();
  }

  Future<void> _loadPref() async {
    prefs = await SharedPreferences.getInstance();
    email = prefs.getString("email") ?? '';
    if (email == '') {
      _loademaildialog();
    } else {}
  }

  /* void _loadCart() {
    http.post(
        Uri.parse(
            "https://fluttermycuckoodb.000webhostapp.com/php/load_cart_item.php"),
        body: {"email": widget.user.email}).then((response) {
      setState(() {
        cartitem = int.parse(response.body);
      });
    });
  }*/

  void _loademaildialog() {
    TextEditingController _emailController = new TextEditingController();
    showDialog(
        builder: (context) => new AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                title: new Text(
                  'Your Email',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                actions: <Widget>[
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.email,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: Colors.white24)),
                              )),
                          ElevatedButton(
                              onPressed: () async {
                                String _email =
                                    _emailController.text.toString();
                                prefs = await SharedPreferences.getInstance();
                                await prefs.setString("email", _email);
                                email = _email;
                                Fluttertoast.showToast(
                                    msg: "Email stored",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.TOP,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor:
                                        Color.fromRGBO(191, 30, 46, 50),
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                                Navigator.of(context).pop();
                              },
                              child: Text("Proceed"))
                        ],
                      ),
                    ),
                  ),
                ]),
        context: context);
  }
}
