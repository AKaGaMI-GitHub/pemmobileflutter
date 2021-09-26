import 'package:flutter/material.dart';
import 'package:latihan/Model/barang.dart';
import 'package:latihan/Services/apiStatic.dart';
import 'package:latihan/UI/cartPage.dart';
import 'package:latihan/UI/detailbarang/detailBarang.dart';
import 'package:latihan/UI/search.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar kepala
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        title: Text("Bali Blacksmith"),
      ),
      //body
      body: FutureBuilder<List<Barang>>(
        future: ApiStatic.getBarang(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            List<Barang> barangs = snapshot.data!;
            return Container(
                child: ListView.builder(
              itemCount: barangs.length,
              itemBuilder: (BuildContext context, int index) => Column(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) =>
                              DetailBarangPage(barang: barangs[index])));
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10),
                      width: 350,
                      height: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          border: Border.all(
                              width: 2, color: Colors.green.shade600)),
                      child: (Row(
                        children: [
                          Container(
                              width: 60,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(barangs[index].foto)))),
                          Text(
                            barangs[index].namaBarang,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )),
                    ),
                  )
                ],
              ),
            ));
          }
        },
      ),

      //navbar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0, //index 0 = homepage, 1 = search, 2 = cart
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
