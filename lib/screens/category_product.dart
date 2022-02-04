import 'package:debutproject/screens/product_details.dart';
import 'package:debutproject/services/api_services.dart';
import 'package:flutter/material.dart';

class CategoryProduct extends StatelessWidget {
  final String catName;
  CategoryProduct(this.catName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(catName.toUpperCase()),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.redAccent,
      ),
      body: FutureBuilder(
          future: ApiService().getProductByCategory(catName),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
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
                  });
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
