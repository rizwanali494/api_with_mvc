import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

import '../Models/post_post_model.dart';

class ProductController {
  Future<ProductResponse?> addProduct(ProductRequest product) async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts'); // Replace with your API endpoint
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode(product.toJson()),
    );

    print("Response Status Code: ${response.statusCode}");
    print("Response Body: ${response.body}");

    if (response.statusCode == 201) {
      Toast.show("Product Added Successfully",gravity: Toast.bottom, duration: Toast.lengthShort);
      return ProductResponse.fromJson(jsonDecode(response.body));
    } else {
      Toast.show("Failed to add product" , gravity: Toast.bottom, duration: Toast.lengthShort);
      print("Failed to add product. Status Code: ${response.statusCode}");
      return null;
    }
  }
}
