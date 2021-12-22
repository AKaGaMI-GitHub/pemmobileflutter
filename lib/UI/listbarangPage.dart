import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:latihan/Model/barang.dart';
import 'package:latihan/Model/errMsg.dart';
import 'package:latihan/Services/apiStatic.dart';
import 'package:latihan/UI/detailbarang/detailBarang.dart';
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
  final PagingController<int, Barang> _pagingController =
      PagingController(firstPageKey: 0);
  late TextEditingController _s;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late String _publish = "Y";
  int _pageSize = 2;
  void deleteBarang(idBarang) async {
    response = await ApiStatic.deleteBarang(idBarang);
    final snackBar = SnackBar(
      content: Text(response.message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> _fetchPage(int pageKey, _s, _publish) async {
    try {
      final newItems = await ApiStatic.getBarangFilter(pageKey, _s, _publish);
      final isLastPage = newItems.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        _pagingController.appendPage(newItems, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    _s = TextEditingController();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey, _s.text, _publish);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar kepala
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        title: Text("List Product"),
      ),
      drawer: Drawer(),
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
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.fromLTRB(30, 10, 30, 10),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: RefreshIndicator(
            onRefresh: () => Future.sync(() => _pagingController.refresh()),
            child: PagedListView<int, Barang>(
                pagingController: _pagingController,
                builderDelegate: PagedChildBuilderDelegate<Barang>(
                  itemBuilder: (context, item, index) => Container(
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DetailBarangPage(barang: item)));
                      },
                      child: Container(
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
                              item.namaBarang,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          new MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  InputbarangPage(
                                                    barang: item,
                                                  )));
                                    },
                                    child: Icon(Icons.edit)),
                                GestureDetector(
                                    onTap: () {
                                      deleteBarang(item.idBarang);
                                    },
                                    child: Icon(Icons.delete))
                              ],
                            )
                          ],
                        )),
                      ),
                    ),
                  ),
                )),
          ),
        ),
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
