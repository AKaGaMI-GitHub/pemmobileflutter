import 'package:flutter/material.dart';
import 'package:latihan/Model/barang.dart';

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
      body: ListView(children: [
        Container(
          child: Column(
            children: [
              // Container(
              //   width: 500,
              //   height: 300,
              //   child: Image(image: AssetImage(widget.barang.foto)),
              // ),
              Container(
                alignment: Alignment.centerLeft,
                width: 500,
                height: 60,
                decoration: BoxDecoration(color: Colors.black12),
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  widget.barang.namaBarang,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
              )
            ],
          ),
        )
      ]),

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
