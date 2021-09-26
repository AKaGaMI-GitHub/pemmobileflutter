import 'package:flutter/material.dart';
import 'package:latihan/UI/homePage.dart';
import 'package:latihan/UI/search.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar kepala
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        title: Text("Your Cart"),
      ),

      //navbar
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
                  builder: (BuildContext context) => CartPage()));
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
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Carts',
          ),
        ],
      ),
    );
  }
}
