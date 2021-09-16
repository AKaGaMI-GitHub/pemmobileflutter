import 'package:flutter/material.dart';
import 'package:latihan/Model/barang.dart';
import 'package:latihan/Services/apiStatic.dart';
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
                child: InkWell(
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        DetailBarangPage(barang: barangs[1])));
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(13, 10, 13, 5),
                    child: Text(
                      "Hi, Good Afternoon",
                      style:
                          TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(13, 10, 13, 5),
                    child: Text("Best Seller on the Year",
                        style: TextStyle(fontSize: 19)),
                  ),
                  //list produk
                  SingleChildScrollView(
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green.shade600),
                            ),
                            width: 175,
                            height: 250,
                            child: Column(
                              children: [
                                Container(
                                    width: 190,
                                    height: 190,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage(barangs[0].foto)))),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green.shade300),
                                  width: 195,
                                  height: 58,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        barangs[0].namaBarang,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Rp.${barangs[0].harga}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.fromLTRB(20, 10, 10, 10),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.green.shade600),
                            ),
                            width: 175,
                            height: 250,
                            child: Column(
                              children: [
                                Container(
                                    width: 190,
                                    height: 190,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image:
                                                AssetImage(barangs[1].foto)))),
                                Container(
                                  decoration: BoxDecoration(
                                      color: Colors.green.shade300),
                                  width: 195,
                                  height: 58,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        barangs[1].namaBarang,
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "Rp.${barangs[1].harga}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
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
