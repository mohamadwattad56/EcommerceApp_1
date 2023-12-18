import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/Products_List.dart';
import '../screens/favorite_products_page.dart';
import '../providers/cart.dart';

/*This code provides a detailed page for a specific product,
 allowing users to view its details,
 add it to the cart, and toggle its favorite status.
 The page uses Provider for state management to interact with the product and cart data.*/



class ProductDetailPage extends StatefulWidget {
  final String productId;

  ProductDetailPage({required this.productId});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {

  void showCart() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        var cartProducts = Provider.of<Cart_List>(context).cartProducts;
        double total = Provider.of<Cart_List>(context).total;
        // Build the UI for the modal bottom sheet
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {

            // Return a column layout with product details and total price
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartProducts.length,
                    itemBuilder: (context, index) {
                      final item = cartProducts[index];;
                      return Card(
                        child: Row(
                          children: [
                            Image.asset(item.imageUrl,
                                width: 80, height: 80, fit: BoxFit.cover),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "\$${item.price}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {
                                          setState(() {
                                            if (item.quantity > 1) {
                                              item.quantity -= 1;
                                            } else {
                                              Provider.of<Cart_List>(context, listen: false).removeFromCart(item.id);

                                            }
                                          });
                                        },
                                      ),
                                      Text(
                                        "Quantity: ${item.quantity}",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      IconButton(
                                        icon: Icon(Icons.add),
                                        onPressed: () {
                                          setState(() {
                                            item.quantity += 1;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                  Text(
                                      "Final Price: \$${(item.price * item.quantity).toStringAsFixed(2)}"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Divider(color: Colors.grey),
                Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Summary',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Total: \$${total.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }


  void addToCartFromDetailPage() {
    // First we get the Product instance using productId
    Product TheProduct = Provider.of<ProductState>(context, listen: false)
        .products
        .firstWhere((p) => p.id == widget.productId);

    // Then we add it to the cart using Cart_List provider
    Provider.of<Cart_List>(context, listen: false).addToCart(TheProduct);
  }



  void ChangeFavorite() {
    Provider.of<ProductState>(context, listen: false)
        .toggleFavorite(widget.productId);//from here we go to the toggleFavorite method that in Product_List
  }

  @override
  Widget build(BuildContext context) {
    // Access the available products and find the current product by ID
    List<Product> AvailableProducts = Provider.of<ProductState>(context).products;
    Product ChangedProduct = Provider.of<ProductState>(context).products.firstWhere((p) => p.id == widget.productId);
    return Scaffold(
      appBar: AppBar(
        title: Text(ChangedProduct.name, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteProductsPage(
                      favoriteProducts:
                          AvailableProducts.where((p) => p.isFavorite)
                              .toList()),
                ),
              );
            },
          ),

          Consumer<Cart_List>(
            builder: (context, Cart_List, child) {
              int cartCount = Cart_List.cartProducts.length;
              return Stack(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.shopping_cart, color: Colors.white),
                    onPressed: showCart,
                  ),
                  if (Cart_List.cartProducts.length > 0)
                    Positioned(
                      right: 0,
                      top: 0,
                      child: Container(
                        padding: EdgeInsets.all(1),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: Text(
                          '$cartCount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Image.asset(
              ChangedProduct.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  ChangedProduct.name,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "\$${ChangedProduct.price}",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  "Description",
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                SizedBox(height: 4),
                Text(
                  ChangedProduct.description,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        ChangedProduct.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: Colors.red,
                      ),
                      onPressed: ChangeFavorite,
                    ),
                    IconButton(
                      icon: Icon(Icons.shopping_cart, color: Colors.black),
                      onPressed: addToCartFromDetailPage,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
