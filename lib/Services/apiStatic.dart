import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:latihan/Model/barang.dart';
import 'package:latihan/Model/errMsg.dart';
import 'package:latihan/Model/penjual.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiStatic {
  static final host = 'http://192.168.18.120/APIMobile/';
  static final _token = "10|t7J7onSeKAAnAHGurec9im4jejVVoNskZO7vlAIU";
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
        final parsed = json['data']['data'].cast<Map<String, dynamic>>();
        return parsed.map<Barang>((json) => Barang.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      return [];
    }
  }

  static Future<List<Barang>> getBarangFilter(
      int pageKey, String _s, String _selectedChoice) async {
    try {
      final response = await http.get(
          // Uri.parse(
          //     "http://192.168.18.120/APIMobile/public/api/databarang?page=1&s=&publish=Y"),
          Uri.parse(
              "http://192.168.18.120/APIMobile/public/api/databarang?page=" +
                  pageKey.toString() +
                  "&s=" +
                  _s +
                  "&publish=" +
                  _selectedChoice),
          headers: {
            'Authorization': 'Bearer ' + _token,
          });
      if (response.statusCode == 200) {
        var json = jsonDecode(response.body);
        print(json["data"]['data']);
        final parsed = json['data']['data'].cast<Map<String, dynamic>>();
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
          Uri.parse('http://192.168.18.120/APIMobile/public/api/datapenjual'),
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

  static Future<ErrorMSG> saveBarang(idBarang, barangs, filepath) async {
    try {
      var url =
          Uri.parse('http://192.168.18.120/APIMobile/public/api/databarang');
      if (idBarang != 0) {
        url = Uri.parse(
            'http://192.168.18.120/APIMobile/public/api/databarang' +
                idBarang.toString());
      }

      var request = http.MultipartRequest('POST', url);
      request.fields['namaBarang'] = barangs['namaBarang'];
      request.fields['idPenjual'] = barangs['idPenjual'].toString();
      request.fields['foto'] = barangs['foto'];
      request.fields['harga'] = barangs['harga'];
      if (filepath != '') {
        request.files.add(await http.MultipartFile.fromPath('foto', filepath));
      }
      request.headers.addAll({
        'Authorization': 'Bearer ' + _token,
      });
      var response = await request.send();
      if (response.statusCode == 200) {
        final respStr = await response.stream.bytesToString();
        print(jsonDecode(respStr));
        return ErrorMSG.fromJson(jsonDecode(respStr));
      } else {
        return ErrorMSG(success: false, message: 'err Request');
      }
    } catch (e) {
      ErrorMSG responseRequest =
          ErrorMSG(success: false, message: 'err caught: $e');
      return responseRequest;
    }
  }

  static Future<ErrorMSG> deleteBarang(idBarang) async {
    try {
      final response = await http.delete(
          Uri.parse('http://192.168.18.120/APIMobile/public/api/' +
              idBarang.toString()),
          headers: {
            'Authorization': 'Bearer ' + _token,
          });
      if (response.statusCode == 200) {
        return ErrorMSG.fromJson(jsonDecode(response.body));
      } else {
        return ErrorMSG(success: false, message: 'err Request');
      }
    } catch (e) {
      ErrorMSG responseRequest =
          ErrorMSG(success: false, message: 'Error caught : $e');
      return responseRequest;
    }
  }

  static Future<ErrorMSG> signIn(_post) async {
    try {
      final response = await http.post(
          Uri.parse('http://192.168.18.120/APIMobile/public/api/login'),
          body: _post);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', res['content']['access_token']);
        print(res);
        prefs.setInt('level', 1);
        return ErrorMSG.fromJson(res);
      } else {
        print(response.statusCode);
        return ErrorMSG.fromJson(jsonDecode(response.body));
      }
    } catch (e) {
      ErrorMSG responseRequest =
          ErrorMSG(success: false, message: 'error caught: $e');
      return responseRequest;
    }
  }
}
