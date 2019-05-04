import 'dart:convert';

import 'package:currency_converter/APIS/finance.dart';
import 'package:http/http.dart' as http;

Future<Map> getData() async {
  http.Response response = await http.get(FINACE);
  return json.decode(response.body);
}
