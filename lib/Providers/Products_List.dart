import 'package:flutter/material.dart';
import '../models/product.dart'; // Importing the Product details from product.dart


// A list of products available in the application.
List<Product> AvailableProducts = [
  Product(
    id: '1',
    name: 'DE MARLY',
    description:
        'Top notes: Mandarin, Apple, Lavender. Heart notes: Violet, Jasmine, Geranium. Base notes: Guaiac wood, Patchouli, Sandalwood, Cardamom, Vanilla, Pepper. Design house: Parfums De Marly.',
    price: 315.00,
    imageUrl: 'assets/images/id.1.jpg',
    category: 'Niche Fragrances',
  ),
  Product(
    id: '2',
    name: 'YVES SAINT LAURENT',
    description:
        'Top notes: White aldehydes, Bergamot, Ginger. Heart notes: Sage, Geranium, Violet leaf. Base notes: Ambergris, Incense, Fir balsam, Cedarwood, Musk. Design house: Ysl. Scent.',
    price: 71.99,
    imageUrl: 'assets/images/id.2.jpg',
    category: 'Testers & Mini',
  ),
  Product(
    id: '3',
    name: 'VERSACE',
    description:
        'Top notes: Mint, Lemon. Heart notes: Green apple, Geranium. Base notes: Amber, Tonka bean. Design house: Versace. Scent name: Versace Eros Parfum.',
    price: 78.80,
    imageUrl: 'assets/images/id.3.jpg',
    category: 'Testers & Mini',
  ),
  Product(
    id: '4',
    name: 'TOM FORD',
    description: 'An oriental woody fragrance for men Crisp, spicy, sweet, tasty, warm & tantalizing Top notes of mandarin oil, neroli, saffron, cardamom & nutmeg Heart notes of Indian kulfi dessert, rose absolute, jasmine, orange blossom & mastic accord Base notes of amber, sandalwood & vanilla Launched in 2015 Recommended for fall or winter wear',
    price: 152.99,
    imageUrl: 'assets/images/id.4.jpg',
    category: 'Niche Fragrances',
  ),
  Product(
    id: '5',
    name: 'CREED',
    description:
        'The exceptional Aventus was inspired by the dramatic life of a historic emperor, celebrating strength, power and success. Introduced in 2010 and crafted by the deft hand of Sixth Generation Master Perfumer Olivier Creed in colladyration with his son Erwin, this scent has grown to become the best-selling fragrance in the history of the brand.',
    price: 212.99,
    imageUrl: 'assets/images/id.5.jpg',
    category: 'Niche Fragrances',
  ),
  Product(
    id: '6',
    name: 'AL HARAMAIN',
    description:
        'Top notes: Bergamot, Green. Heart notes: Melon, Pineapple, Gourmand notes, Amber. Base notes: Woods, Vanilla, Musk. Design house: Al Haramain. Scent name: Amber Oud Gold Edition.',
    price: 39.99,
    imageUrl: 'assets/images/id.6.jpg',
    category: 'Middle Eastern',
  ),
  Product(
    id: '7',
    name: 'LATTAFA',
    description: '',
    price: 32.00,
    imageUrl: 'assets/images/id.7.jpg',
    category: 'Middle Eastern',
  ),
  Product(
    id: '8',
    name: 'ARMAF',
    description:
        'Top notes: Lemon, Blackcurrant, Apple. Heart notes: Jasmine, Birch. Base notes: Vanilla, Ambergris, Musk, Patchouli. Design house: Armaf. Scent name: Club De Nuit Intense.',
    price: 29.99,
    imageUrl: 'assets/images/id.8.jpg',
    category: 'Middle Eastern',
  ),
];


// The ProductState class, used to manage the state of products.
class ProductState with ChangeNotifier {
  List<Product> _MyProducts = [];


  // ctor to initialize the state with a list of products.
  ProductState(List<Product> initialProducts) {
    _MyProducts = initialProducts;
  }


  // Getter to expose the list of products.
  List<Product> get products => _MyProducts;
  void addProduct(Product product) {
    _MyProducts.add(product);
    notifyListeners(); // Notifies listeners about the change.
  }

  void removeProduct(String productId) {
    _MyProducts.removeWhere((p) => p.id == productId);
    notifyListeners();
  }


  // Method to toggle the favorite status of a product bt calling ChangeFavoriteStatus method
  void toggleFavorite(String productId) {
    int index = _MyProducts.indexWhere((p) => p.id == productId);
    if (index != -1) {
      _MyProducts[index].ChangeFavoriteStatus();//from here we go to the ChangeFavoriteStatus method that in Product.dart
      notifyListeners();
    }
  }


  // Method to filter products by category.
  List<Product> getProductsByCategory(String category) {
    if (category == 'All') {
      return _MyProducts;
    } else {
      return _MyProducts
          .where((product) => product.category == category)
          .toList();
    }
  }
}
