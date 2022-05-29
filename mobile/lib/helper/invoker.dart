import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mobile/constants.dart';

class Invoker{

  static Future<dynamic> post(String path, Map<String, String> body) async{
    dynamic response = http.post(Uri.http(serverHost, path), body: body);
    return jsonDecode(response);
  }

}