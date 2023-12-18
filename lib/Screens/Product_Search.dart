import 'package:flutter/material.dart';
import '../providers/Products_List.dart';
import 'product_detail_page.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';


/* A custom SearchDelegate for searching products.

/This delegate handles both the search actions and the UI for displaying
 search results and suggestions.*/

class Product_Search extends SearchDelegate {
  final List<Product> products;

  Product_Search(this.products);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final products = Provider.of<ProductState>(context).products;
    final results = products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();


    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final product = results[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text("\$${product.price}"),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => ProductDetailPage(
                productId: product.id,

              ),
            ));
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final products = Provider.of<ProductState>(context).products;
    final suggestions = products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        final product = suggestions[index];
        return ListTile(
          title: Text(product.name),
          subtitle: Text("\$${product.price}"),
          onTap: () {
            query = product.name;
            showResults(context);
          },
        );
      },
    );
  }
}
