import 'package:flutter_json_api/api/model.dart';

class Method {
  Map<String, dynamic>? product;

  Map<String, dynamic> eksekusi({required product}) {
    if (product == null) {
      return {"error": true, "message": "Product Null"};
    }

    if (product!['error'] == true) {
      return {"error": true, "message": "Product Error"};
    }

    if (product!['data'] == null) {
      return {"error": true, "message": "Product Data Null"};
    }

    return {"error": false, "message": " Success "};
  }
}
