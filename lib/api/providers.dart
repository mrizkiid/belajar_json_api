import 'package:flutter_json_api/api/model.dart';
import 'package:http/http.dart' as http;

class Providers {
  Future<Map<String, dynamic>> getData() async {
    try {
      Uri uri = Uri.parse('https://dummyjson.com/products');
      var response = await http.get(uri);
      String json = response.body;

      if (response.statusCode != 200) {
        return {"error": true, "message": 'Failed ${response.statusCode}'};
      }

      return {
        "error": false,
        "message": 'Success',
        "data": productModelFromJson(json)
      };
    } catch (e) {
      return {"error": true, "message": 'Failed $e'};
    }
  }
}
