//This screen is Product Detail Screen
import 'dart:convert';
import '/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductScreen extends StatefulWidget {
  final User user;
  const ProductScreen({Key key, this.user}) : super(key: key);
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  double screenHeight, screenWidth, resWidth;
  List _productList = [];
  String titleCenter = "Loading...";

  final List<int> num = [1, 2, 3];

  @override
  void initState() {
    super.initState();
    _loadProduct("all");
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(189, 145, 136, 1),
        title: Text(
          'Cuckoo Product',
          style: TextStyle(
            color: Color.fromRGBO(178, 35, 52, 1),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: TextButton.icon(
              onPressed: () => {_deleteProduct},
              icon: Icon(
                Icons.delete,
                color: Colors.black87,
              ),
              label: Text(''),
            ),
          ),
        ],
      ),
      body: Stack(children: [upperHalf(context), lowerHalf(context)]),
    );
  }

  Widget upperHalf(BuildContext context) {
    return Scaffold(
        body: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
            height: MediaQuery.of(context).size.height * 0.35,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: num.length,
                itemBuilder: (context, index) {
                  return SizedBox(
                      width: MediaQuery.of(context).size.width * 0.6,
                      child: Card(
                          color: Colors.blueGrey,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(3, 3, 3, 3),
                            child: CachedNetworkImage(
                              width: screenWidth,
                              fit: BoxFit.cover,
                              imageUrl:
                                  "https://fluttermycuckoodb.000webhostapp.com/images/1" +
                                      "_" +
                                      num[index].toString() +
                                      ".png",
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      LinearProgressIndicator(
                                          value: downloadProgress.progress),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          )));
                })));
  }

  Widget lowerHalf(BuildContext context) {
    return Container(
      height: 600,
      margin: EdgeInsets.only(top: screenHeight / 3),
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SingleChildScrollView(
          child: Column(
        children: [
          Text(
            "CUCKOO NAME: ",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text('Prince Top'),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              elevation: 10,
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Table(
                  columnWidths: const {
                    0: FractionColumnWidth(0.4),
                    1: FractionColumnWidth(0.6)
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.top,
                  children: [
                    TableRow(children: [
                      const Text('Type',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold)),
                      Text('Water Filter'),
                    ]),
                    TableRow(children: [
                      const Text('Quantity',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold)),
                      Text('3'),
                    ]),
                    TableRow(children: [
                      const Text('Price',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.bold)),
                      Text('RM 4 800'),
                    ]),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  _deleteProduct(int index) {
    http.post(
        Uri.parse(
            "https://fluttermycuckoodb.000webhostapp.com/php/delete_product.php"),
        body: {"prid": _productList[index]['prid']}).then((response) {
      print(response.body);
      if (response.body == "success") {
        Fluttertoast.showToast(
            msg: "Success",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 16.0);
        _loadProduct("all");
        return;
      } else {
        Fluttertoast.showToast(
            msg: "Failed",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.greenAccent,
            textColor: Colors.black,
            fontSize: 16.0);
      }
    });
  }

  String titleSub(String title) {
    if (title.length > 15) {
      return title.substring(0, 15) + "...";
    } else {
      return title;
    }
  }

  _loadProduct(String prname) {
    String prname = "all";
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
}
