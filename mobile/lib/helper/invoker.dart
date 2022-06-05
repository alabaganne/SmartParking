import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/constants.dart';

class Invoker{

  static Future<Map> post(String path, Map<String, dynamic> body, {bool decodeResponse = true}) async{
    http.Response response = await http.post(Uri.http(Ip.serverHost, path), body: body);

    if (decodeResponse){
      return jsonDecode(response.body);

    }
    return {
      "result": response.body
    };
  }

  static Future<dynamic> get(String path, {Map<String, dynamic>? query}) async{
    http.Response response = await http.get(Uri.http(Ip.serverHost, path, query));
    return jsonDecode(response.body);
  }

  static Future<dynamic> delete(String path) async{
    http.Response response = await http.delete(Uri.http(Ip.serverHost, path));
    return response.body;
  }

}