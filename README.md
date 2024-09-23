# ecommerceapp_1

A new Flutter project.

## Getting Started
# E-commerce App with Provider and Theme Switching

This is an e-commerce app built using Flutter. The app demonstrates the use of `Provider` for state management and includes features like adding products to the cart, managing a favorite products list, and switching between light and dark themes.

## Features

- **Product Management:** Add, remove, and update products from the cart.
- **Favorites Management:** Mark products as favorites, view the favorite products list, and remove products from favorites.
- **Cart Management:** Manage the quantity of products in the cart and view the total price.
- **Theme Switching:** Users can toggle between light and dark modes.
- **State Management with Provider:** All state management (cart, products, theme) is handled using the `Provider` package.

## Project Structure

The project is organized into the following major files:

- `main.dart`: The entry point of the app. It sets up the `ChangeNotifierProvider` for managing global state (products and theme) and defines the main routes.
- `product.dart`: The model class for products, defining the product properties and methods for toggling favorites.
- `product_model.dart`: Contains the `ProductModel` class, which is used to manage the list of products, favorite products, and product-related actions using `ChangeNotifier`.
- `theme_model.dart`: Manages the app's theme (light or dark mode) using `ChangeNotifier`.
- `theme.dart`: Defines the light and dark themes used in the app.

## Getting Started

### Prerequisites

To run this app, you need to have the following installed on your machine:

- Flutter SDK: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- Dart SDK (included with Flutter)
- An IDE such as [Android Studio](https://developer.android.com/studio) or [VS Code](https://code.visualstudio.com/)

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/mohamadwattad56/EcommerceApp_1.git
   cd EcommerceApp_1
