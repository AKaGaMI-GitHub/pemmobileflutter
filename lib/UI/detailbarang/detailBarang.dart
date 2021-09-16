import 'package:flutter/material.dart';
import 'package:latihan/Model/barang.dart';
import 'package:latihan/UI/homePage.dart';
import 'package:latihan/UI/search.dart';

class DetailBarangPage extends StatefulWidget {
  DetailBarangPage({required this.barang});
  final Barang barang;
  @override
  _DetailBarangPageState createState() => _DetailBarangPageState();
}

class _DetailBarangPageState extends State<DetailBarangPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        title: Text("Detail Product"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Text("Belum Fix"),
        ),
      ),

      //navbar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: 'Take it to Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.attach_money,
            ),
            label: 'Checkout',
          ),
        ],
      ),
    );
  }
}
