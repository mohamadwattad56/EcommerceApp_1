import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/Products_List.dart';

class FavoriteProductsPage extends StatelessWidget {
  final List<Product> favoriteProducts;

  FavoriteProductsPage({required this.favoriteProducts});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Products'),
      ),
      body: ListView.builder(
        itemCount: Provider.of<ProductState>(context)
            .products
            .where((p) => p.isFavorite)
            .length,
        itemBuilder: (ctx, index) {
          var product = Provider.of<ProductState>(context)
              .products
              .where((p) => p.isFavorite)
              .toList()[index];
          return ListTile(
            leading: Image.asset(product.imageUrl,
                width: 50, height: 50, fit: BoxFit.cover),
            title: Text(
              product.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            subtitle: Text(
              "\$${product.price}",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.favorite, color: Colors.red),
              onPressed: () {
                Provider.of<ProductState>(context, listen: false)
                    .toggleFavorite(product.id);
              },
            ),
          );
        },
      ),
    );
  }
}
