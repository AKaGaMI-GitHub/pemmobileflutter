import 'package:latihan/Model/barang.dart';

class ApiStatic {
  static Future<List<Barang>> getBarang() async {
    List<Barang> barangs = [
      Barang(
          idBarang: 1,
          namaBarang: "Balinese Keris",
          idPenjual: 1,
          foto: "asset/images/krisbali.png",
          harga: 150000),
      Barang(
          idBarang: 2,
          namaBarang: "Clurit",
          idPenjual: 2,
          foto: "asset/images/clurit.png",
          harga: 100000),
    ];

    return barangs;
  }
}
