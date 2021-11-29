import 'package:flutter/material.dart';
import 'package:latihan/Model/barang.dart';
import 'package:latihan/Model/errMsg.dart';
import 'package:latihan/Services/apiStatic.dart';
import 'package:latihan/UI/homePage.dart';
import 'package:latihan/UI/inputbarangPage.dart';
import 'package:latihan/UI/search.dart';

class ListbarangPage extends StatefulWidget {
  @override
  _ListbarangPageState createState() => _ListbarangPageState();
}

class _ListbarangPageState extends State<ListbarangPage> {
  //final Barang barang;
  //InputbarangPage({required this.barang});
  late ErrorMSG response;
  void deleteBarang(idBarang) async {
    response = await ApiStatic.deleteBarang(idBarang);
    final snackBar = SnackBar(
      content: Text(response.message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar kepala
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        title: Text("List Product"),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green.shade600,
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InputbarangPage(
                          barang: Barang(
                              idBarang: 0,
                              namaBarang: '',
                              idPenjual: 0,
                              foto: '',
                              hargaBarang: 0),
                        )));
          }),
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
                      itemBuilder: (BuildContext context, int index) =>
                          Column(children: [
                            Container(
                              margin: EdgeInsets.only(top: 10),
                              width: 370,
                              height: 70,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                      width: 2, color: Colors.green.shade600)),
                              child: (Row(
                                children: [
                                  Text(
                                    barangs[index].namaBarang,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            Navigator.of(context).push(
                                                new MaterialPageRoute(
                                                    builder: (BuildContext
                                                            context) =>
                                                        InputbarangPage(
                                                          barang:
                                                              barangs[index],
                                                        )));
                                          },
                                          child: Icon(Icons.edit)),
                                      GestureDetector(
                                          onTap: () {
                                            deleteBarang(
                                                barangs[index].idBarang);
                                          },
                                          child: Icon(Icons.delete))
                                    ],
                                  )
                                ],
                              )),
                            ),
                          ])));
            }
          }),
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
                  builder: (BuildContext context) => ListbarangPage()));
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
