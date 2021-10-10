import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latihan/Model/barang.dart';

class ApiStatic {
  static Future<List<Barang>> getBarang() async {
    //String response ='{"data":[{"idBarang":4,"namaBarang":"Clurit","idPenjual":2,"foto":"asset\/images\/clurit.png","hargaBarang":100000,"created_at":"2021-09-25T20:38:48.000000Z","updated_at":"2021-09-25T20:38:48.000000Z"},{"idBarang":3,"namaBarang":"Balinese Keris","idPenjual":1,"foto":"asset\/images\/krisbali.png","hargaBarang":140000,"created_at":"2021-09-25T20:37:53.000000Z","updated_at":"2021-09-25T20:37:53.000000Z"}]}';
    try {
      final response = await http.get(
          Uri.parse('http://192.168.18.120/APIMobile/public/api/databarang'));
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        final parsed = json['data'].cast<Map<String, dynamic>>();
        return parsed.map<Barang>((json) => Barang.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
