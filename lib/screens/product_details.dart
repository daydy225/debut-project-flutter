import 'package:debutproject/services/api_services.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatelessWidget {
  final int id;
  ProductDetails(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Product Details"),
          backgroundColor: Colors.redAccent,
          centerTitle: true,
          elevation: 0),
      body: FutureBuilder(
        future: ApiService().getSingleProduct(id),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Image.network(
                    snapshot.data["image"],
                    height: 200,
                    width: double.infinity,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      "\$" + snapshot.data["price"].toString(),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    snapshot.data["title"],
                    style: TextStyle(
                      fontSize: 26,
                    ),
                  ),
                  Chip(
                    label: Text(
                      snapshot.data["category"],
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    backgroundColor: Colors.blueGrey,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    snapshot.data["description"],
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  )
                ],
              ),
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await ApiService().updateCart(1, id);
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Product added to cart")));
        },
        child: Icon(Icons.add_shopping_cart_outlined),
        backgroundColor: Colors.green,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
