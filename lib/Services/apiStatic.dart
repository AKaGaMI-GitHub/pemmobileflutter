import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:latihan/Model/barang.dart';
import 'package:latihan/Model/penjual.dart';

class ApiStatic {
  static final host = 'http://192.168.18.120/APIMobile/';
  static final _token = "7|JXs2Bfu2DUdrNnCetLflQkWRpXtcrl3ShtQtR0ij";
  static getHost() {
    return host;
  }

  static Future<List<Barang>> getBarang() async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.18.120/APIMobile/public/api/databarang'),
          headers: {
            'Authorization': 'Bearer ' + _token,
          });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print(json);
        final parsed = json['data'].cast<Map<String, dynamic>>();
        return parsed.map<Barang>((json) => Barang.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<List<Penjual>> getNamaPenjual() async {
    try {
      final response = await http.get(
          Uri.parse('http://192.168.18.120/APIMobile/public/api/databarang'),
          headers: {
            'Authorization': 'Bearer ' + _token,
          });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print(json);
        final parsed = json.cast<Map<String, dynamic>>();
        return parsed.map<Penjual>((json) => Penjual.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
