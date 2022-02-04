import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  Future getAllPosts() async {
    final allProductsUrl = Uri.parse("https://fakestoreapi.com/products");
    final response = await http.get(allProductsUrl);
    // print(response.statusCode);
    // print(response.body);
    return json.decode(response.body);
  }

  Future getSingleProduct(int id) async {
    final singleProductUrl = Uri.parse("https://fakestoreapi.com/products/$id");
    final response = await http.get(singleProductUrl);
    // print(response.statusCode);
    // print(response.body);
    return json.decode(response.body);
  }

  Future getAllCategory() async {
    final allCategoryUrl =
        Uri.parse("https://fakestoreapi.com/products/categories");
    final response = await http.get(allCategoryUrl);
    // print(response.statusCode);
    // print(response.body);
    return json.decode(response.body);
  }

  Future getProductByCategory(String catName) async {
    final catProductUrl =
        Uri.parse("https://fakestoreapi.com/products/category/$catName");
    final response = await http.get(catProductUrl);
    // print(response.statusCode);
    // print(response.body);
    return json.decode(response.body);
  }

  Future getCart(String userId) async {
    final cartUrl = Uri.parse("https://fakestoreapi.com/carts/$userId");
    final response = await http.get(cartUrl);
    // print(response.statusCode);
    // print(response.body);
    return json.decode(response.body);
  }

  // POST REQUEST

  Future userLogin(String userName, String password) async {
    final loginUrl = Uri.parse("https://fakestoreapi.com/auth/login");
    final response = await http
        .post(loginUrl, body: {"userName": userName, "password": password});
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

  // PUT REQUEST
  Future updateCart(int userId, int productId) async {
    final upDateCartUrl = Uri.parse("https://fakestoreapi.com/carts/$userId");
    final response = await http.put(upDateCartUrl, body: {
      "userId": "$userId",
      "date": DateTime.now().toString(),
      "products": [
        {"productId": "$productId", 'quantity': "1"}
      ].toString()
    });

    // print(response.statusCode);
    // print(response.body);
    return json.decode(response.body);
  }

  // DELETE REQUEST
  Future deleteCart(String userId) async {
    final deleteCartUrl = Uri.parse("https://fakestoreapi.com/carts/$userId");

    final response = await http.delete(deleteCartUrl);
    print(response.statusCode);
    print(response.body);
    return json.decode(response.body);
  }

// AUTHENTIFICATION REQUEST
  Future userAuthentification(String userName, String password) async {
    final authUrl = Uri.parse("htpp://api.somewhere.io");
    final response = await http
        .post(authUrl, body: {"userName": userName, "password": password});
    print(response.statusCode);
    print(response.body);
  }

  Future userAuthorization(String userName, String password) async {
    final authUrl = Uri.parse("htpp://api.somewhere.io");
    String basicAuth =
        "Basic " + base64Encode(utf8.encode("$userName:$password"));
    final response = await http.get(authUrl, headers: {
      "Content-Type": "application/json",
      "Authorization": basicAuth
    });

    print(response.statusCode);
    print(response.body);
  }

  Future userBearerAuth(String userName, String password) async {
    final authUrl = Uri.parse("htpp://api.somewhere.io");
    // String basicAuth =
    //     "Basic " + base64Encode(utf8.encode("$userName:$password"));
    final acessToken = "Some Token Value";
    final response = await http.get(authUrl, headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $acessToken"
    });

    print(response.statusCode);
    print(response.body);
  }
}
