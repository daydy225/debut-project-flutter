import 'package:debutproject/services/api_services.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  // final String userId;
  // CartScreen(this.userId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Cart"),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.redAccent,
        ),
        body: FutureBuilder(
          future: ApiService().getCart("1"),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List products = snapshot.data["products"];
              return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                        future: ApiService()
                            .getSingleProduct(products[index]["productId"]),
                        builder: (context, AsyncSnapshot asyncSnapshot) {
                          if (asyncSnapshot.hasData) {
                            return ListTile(
                              title: Text(asyncSnapshot.data["title"]),
                              leading: Image.network(
                                asyncSnapshot.data["image"],
                                height: 40,
                              ),
                              subtitle: Text("Quantity - " +
                                  products[index]["quantity"].toString()),
                              trailing: IconButton(
                                onPressed: () async {
                                  await ApiService().deleteCart("1");
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                          content: Text(
                                    "Item deleted successfully",
                                  )));
                                },
                                icon: Icon(Icons.delete),
                                color: Colors.red,
                              ),
                            );
                          }
                          return LinearProgressIndicator();
                        });
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
        bottomNavigationBar: Container(
          height: 60,
          width: double.infinity,
          color: Colors.green,
          child: Center(
            child: Text(
              "ORDER NOW",
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
        ));
  }
}
