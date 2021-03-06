import 'package:debutproject/screens/all_category.dart';
import 'package:debutproject/screens/cart_screen.dart';
import 'package:debutproject/screens/product_details.dart';
import 'package:debutproject/services/api_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.redAccent,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllCategory()));
              },
              icon: Icon(Icons.view_list)),
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CartScreen()));
              },
              icon: Icon(Icons.shopping_cart))
        ],
      ),
      body: FutureBuilder(
          future: ApiService().getAllPosts(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Center(
                child: ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data[index]["title"]),
                        leading: Image.network(
                          snapshot.data[index]["image"],
                          width: 40,
                          height: 40,
                        ),
                        subtitle: Text('Price - \$' +
                            snapshot.data[index]['price'].toString()),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductDetails(
                                      snapshot.data[index]["id"])));
                        },
                      );
                    }),
              );
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
