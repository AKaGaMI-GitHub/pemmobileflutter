import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:latihan/Model/barang.dart';
import 'package:latihan/Model/errMsg.dart';
import 'package:latihan/Services/apiStatic.dart';
import 'package:latihan/UI/homePage.dart';
import 'package:latihan/UI/listbarangPage.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late ErrorMSG response;
  final PagingController<int, Barang> _pagingController =
      PagingController(firstPageKey: 0);
  late TextEditingController _s;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  late String _publish = "Y";
  int _pageSize = 2;
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
        title: Text("Search"),
      ),
      //body
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(15),
                child: Material(
                  elevation: 5.0,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: TextField(
                    controller: _s,
                    onSubmitted: (_s) {
                      _pagingController.refresh();
                    },
                    cursorColor: Theme.of(context).primaryColor,
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    decoration: InputDecoration(
                        hintText: "Masukkan Nama Barang",
                        hintStyle:
                            TextStyle(color: Colors.black38, fontSize: 16),
                        prefixIcon: Material(
                          elevation: 0.0,
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Icon(Icons.search),
                        ),
                        border: InputBorder.none,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 25, vertical: 13)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      //navbar
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, //index 0 = homepage, 1 = search, 2 = cart
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
