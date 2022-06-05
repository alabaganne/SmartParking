import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/constants.dart';

class Invoker{

  static Future<Map> post(String path, Map<String, String> body) async{
    http.Response response = await http.post(Uri.http(Ip.serverHost, path), body: body);

    return jsonDecode(response.body);
  }

  static Future<dynamic> get(String path) async{
    http.Response response = await http.get(Uri.http(Ip.serverHost, path));
    return jsonDecode(response.body);
  }

}