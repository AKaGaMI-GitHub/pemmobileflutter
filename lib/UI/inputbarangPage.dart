import 'package:flutter/material.dart';
import 'package:latihan/UI/cartPage.dart';
import 'package:latihan/UI/homePage.dart';
import 'package:latihan/UI/search.dart';

class InputbarangPage extends StatefulWidget {
  @override
  _InputbarangPageState createState() => _InputbarangPageState();
}

class _InputbarangPageState extends State<InputbarangPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        title: Text("Add Product"),
      ),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 15, 10, 10),
        child: Column(
          children: [
            TextField(
                decoration: InputDecoration(
                    labelText: "Name Product",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                    border: OutlineInputBorder())),
            SizedBox(
              height: 16,
            ),
            TextField(
                decoration: InputDecoration(
                    labelText: "Seller Name",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                    border: OutlineInputBorder())),
            SizedBox(
              height: 16,
            ),
            TextField(
              decoration: InputDecoration(
                  labelText: "Price",
                  labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                  border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            SizedBox(
              height: 16,
            ),
            RaisedButton(onPressed: () {})
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, //index 0 = homepage, 1 = search, 2 = cart
        onTap: (i) {
          switch (i) {
            case 0:
              Navigator.of(context).pushReplacement(new MaterialPageRoute(
                  builder: (BuildContext context) => HomePage()));
              break;
            case 1:
              Navigator.of(context).pushReplacement(new MaterialPageRoute(
                  builder: (BuildContext context) => SearchPage()));
              break;
            case 2:
              Navigator.of(context).pushReplacement(new MaterialPageRoute(
                  builder: (BuildContext context) => InputbarangPage()));
              break;
          }
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_box),
            label: 'Product',
          ),
        ],
      ),
    );
  }
}

class InputbarangState extends State<InputbarangPage> {
  final GlobalKey<InputbarangState> _formkey = GlobalKey<InputbarangState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
