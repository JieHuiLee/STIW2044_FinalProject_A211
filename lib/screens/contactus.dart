import 'package:flutter/material.dart';

class ContactUs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('CONTACT US',
                style: TextStyle(
                    color: Color.fromRGBO(178, 35, 52, 1),
                    fontWeight: FontWeight.bold))
          ],
        ),
        backgroundColor: const Color.fromRGBO(189, 145, 136, 1),
        iconTheme: IconThemeData(color: Colors.black),
        toolbarHeight: 88,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
                color: const Color.fromRGBO(189, 145, 136, 1),
                width: double.infinity,
                height: 250,
                child: Column(children: [
                  Image.asset("assets/images/contactus.png",
                      height: 250, width: 600),
                ])),
            Column(
              children: [
                SizedBox(height: 10),
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40.0,
                ),
                SizedBox(height: 10),
                Text(
                  'Address',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '675, Jalan Sungai Dua,',
                ),
                Text(
                  '11700 Gelugor, Pulau Pinang.',
                ),
                SizedBox(height: 15),
                Icon(
                  Icons.phone_iphone,
                  color: Colors.red,
                  size: 40.0,
                ),
                SizedBox(height: 10),
                Text(
                  'Janace Lee',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '018-7709908',
                ),
                SizedBox(height: 15),
                Icon(
                  Icons.schedule,
                  color: Colors.red,
                  size: 40.0,
                ),
                SizedBox(height: 10),
                Text(
                  'Monday - Friday',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '8am - 5pm',
                ),
                SizedBox(height: 15),
                Text(
                  'Saturday',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '8am - 1pm\n',
                ),
              ],
            )
          ]),
        ),
      ),
    );
  }
}
