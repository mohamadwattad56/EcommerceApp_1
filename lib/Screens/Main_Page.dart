import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/product.dart';
import '../providers/Products_List.dart';
import 'product_detail_page.dart';
import '../screens/favorite_products_page.dart';
import '../screens/Product_Search.dart';
import '../providers/cart.dart';


// Main_Page is a StatefulWidget that represents the main screen of the app.
class Main_Page extends StatefulWidget {
  @override
  _Main_Page_State createState() => _Main_Page_State();
}



class _Main_Page_State extends State<Main_Page> {
  String selectedCategory = 'All';



  void addToCart(Product product) {
    Provider.of<Cart_List>(context, listen: false).addToCart(product);
  }


// Here we display the cart in a modal bottom sheet.
  void showCart() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        // fetching from Cart_List provider.
        var cartItems = Provider.of<Cart_List>(context).cartProducts;
        double total = Provider.of<Cart_List>(context).total;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];;
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



  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = Provider.of<ProductState>(context)
        .getProductsByCategory(selectedCategory);


    // Scaffold is the main structure of the MainPage.
    return Scaffold(
      appBar: AppBar(
        title: Text('Ecommerce App', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search, color: Colors.white),
            onPressed: () {
              showSearch(
                context: context,
                delegate: Product_Search(
                  Provider.of<ProductState>(context, listen: false).products,
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.white),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoriteProductsPage(
                      favoriteProducts:
                          Provider.of<ProductState>(context, listen: false)
                              .products
                              .where((p) => p.isFavorite)
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
      backgroundColor: Colors.black,
      body: Column(
        children: [
          _buildCategoryFilters(),
          Expanded(
            child: GridView.builder(
              itemCount: filteredProducts.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return _buildProductItem(product);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryFilters() {
    List<String> categories = [
      'All',
      'Niche Fragrances',
      'Middle Eastern',
      'Testers & Mini'
    ];
    return Container(
      height: 50,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => SizedBox(width: 10),
        itemBuilder: (context, index) {
          return ChoiceChip(
            label: Text(categories[index]),
            selected: selectedCategory == categories[index],
            onSelected: (bool selected) {
              setState(() {
                selectedCategory = categories[index];
              });
            },
          );
        },
      ),
    );
  }


  // Here we create a widget for a single product item.
  Widget _buildProductItem(Product product) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              productId: product.id,

            ),
          ),
        );
      },
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.asset(
                product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "\$${product.price}",
                    style: TextStyle(fontSize: 14, color: Colors.grey[900]),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(
                          product.isFavorite
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          setState(() {
                            product.ChangeFavoriteStatus();
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.shopping_cart),
                        color: Colors.black,
                        onPressed: () => addToCart(product),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
