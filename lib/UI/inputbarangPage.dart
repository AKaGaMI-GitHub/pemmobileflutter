import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:latihan/Model/barang.dart';
import 'package:latihan/Model/penjual.dart';
import 'package:latihan/Services/apiStatic.dart';

class InputbarangPage extends StatefulWidget {
  final Barang barang;
  InputbarangPage({required this.barang});
  @override
  _InputbarangPageState createState() => _InputbarangPageState();
}

class _InputbarangPageState extends State<InputbarangPage> {
  final _formkey = GlobalKey<FormState>();
  late TextEditingController namabarang, namapenjual, foto, hargabarang;
  late List<Penjual> _namapenjual = [];
  late int idPenjual = 0;
  bool _isupdate = false;
  bool _validate = false;
  late String _imagePath = "";
  late String _imageURL = "";
  //final ImagePicker _picker = ImagePicker();
  final ImagePicker _picker = ImagePicker();
  void getNamaPenjual() async {
    final response = await ApiStatic.getNamaPenjual();
    setState(() {
      _namapenjual = response.toList();
    });
  }

  @override
  void initState() {
    namabarang = TextEditingController(text: widget.barang.namaBarang);
    idPenjual = widget.barang.idPenjual;
    hargabarang =
        TextEditingController(text: widget.barang.hargaBarang.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green.shade600,
        title:
            _isupdate ? Text('Edit Data Product') : Text('Input Data Product'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          key: _formkey,
          child: Form(
              child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: namabarang,
                  validator: (u) => u == "" ? "Required " : null,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.perm_identity),
                    labelText: "Name Product",
                    hintText: "Product Name",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: DropdownButtonFormField(
                  value: idPenjual == 0 ? null : idPenjual,
                  hint: Text("Seller Name"),
                  decoration: const InputDecoration(
                    icon: Icon(Icons.category_rounded),
                  ),
                  items: _namapenjual.map((item) {
                    return DropdownMenuItem(
                        child: Text(item.namaPenjual),
                        value: item.idPenjual.toInt());
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      idPenjual = value as int;
                    });
                  },
                  validator: (u) => u == null ? "Required " : null,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(Icons.image),
                    Flexible(
                        child: _imagePath != ''
                            ? GestureDetector(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: Image.file(
                                    File(_imagePath),
                                    fit: BoxFit.fitWidth,
                                    width: MediaQuery.of(context).size.width,
                                    height:
                                        MediaQuery.of(context).size.height / 5,
                                  ),
                                ),
                                onTap: () {
                                  getImage(ImageSource.gallery);
                                })
                            : _imageURL != ''
                                ? GestureDetector(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        _imageURL,
                                        fit: BoxFit.fitWidth,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                5,
                                      ),
                                    ),
                                    onTap: () {
                                      getImage(ImageSource.gallery);
                                    },
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      getImage(ImageSource.gallery);
                                    },
                                    child: Container(
                                      height: 100,
                                      child: (Row(
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.only(left: 25),
                                          ),
                                          Text("Take A Picture")
                                        ],
                                      )),
                                      decoration: BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  color: Colors.green.shade600,
                                                  width: 1))),
                                    ),
                                  ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: TextFormField(
                  controller: hargabarang,
                  validator: (u) => u == "" ? "Required " : null,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.attach_money),
                    labelText: "Price",
                    hintText: "Product Price",
                    labelStyle: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
              Divider(),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                child: RaisedButton(
                  color: Colors.green,
                  child: Text(
                    "SAVE",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              )
            ],
          )),
        ),
      ),
    );
  }

  Future getImage(ImageSource media) async {
    var img = await _picker.pickImage(source: media);
    setState(() {
      _imagePath = img!.path;
      print(_imagePath);
    });
  }
}
