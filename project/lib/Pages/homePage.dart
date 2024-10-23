// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:project/Pages/DrawerPage.dart';
import 'package:project/Pages/formPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Product> products = []; // List to hold added products
  List<Product> filteredProducts = []; // List to hold filtered products

  // Method to add product to the list
  void addProduct(Product product) {
    setState(() {
      products.add(product); // Add product to the list
      filteredProducts.add(product); // Also add to filtered list
    });
  }

  // Method to delete product from the list
  void deleteProduct(int index) {
    setState(() {
      filteredProducts.removeAt(index); // Remove product from the filtered list
      products.removeAt(index); // Remove from the original list
    });
  }

  // Method to filter products based on the search query
  void filterProducts(String query) {
    setState(() {
      filteredProducts = products.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    filteredProducts = products; // Initially, the filtered list is the same as the original
  }

  // Show search dialog
  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        String searchQuery = "";
        return AlertDialog(
          title: Text('Search Products'),
          content: TextField(
            decoration: InputDecoration(
              labelText: 'Enter product name',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              searchQuery = value; // Update search query
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                filterProducts(searchQuery); // Filter products based on the query
                Navigator.of(context).pop(); // Close dialog
              },
              child: Text('Search'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close dialog
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: _showSearchDialog, // Show search dialog when pressed
            icon: Icon(Icons.search, color: Colors.black),
          ),
        ],
      ),
      drawer: Drawerpage(),
      body: Padding(
        padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
        child: Column(
          children: [
            Text(
              "Hi Fi Shop & Services",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              "Audio shop on Rustaveli Ave 57.",
              style: TextStyle(fontSize: 15.0, color: Colors.black),
            ),
            Text("This shop offers both products and services"),
            SizedBox(height: 20),
            Expanded(
              child: filteredProducts.isEmpty
                  ? Center(child: Text('No Products Found')) // Handle empty list
                  : GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Two columns
                        childAspectRatio: 0.6, // Aspect ratio for grid items
                        crossAxisSpacing: 10.0, // Spacing between columns
                        mainAxisSpacing: 10.0, // Spacing between rows
                      ),
                      itemCount: filteredProducts.length,
                      itemBuilder: (context, index) {
                        final product = filteredProducts[index];
                        return Card(
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Adjust the image widget
                              Expanded(
                                child: Image.file(
                                  File(product.imagePath),
                                  fit: BoxFit.cover, // Ensures the image fits well
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // Ensure the price is formatted correctly
                                    Text(
                                      '\$${product.price.toStringAsFixed(2)}', // Convert double to String
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(Icons.delete, color: Colors.red),
                                onPressed: () {
                                  // Show confirmation dialog before deleting
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text('Delete Product'),
                                      content: Text('Are you sure you want to delete this product?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.of(context).pop(), // Close dialog
                                          child: Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            deleteProduct(index); // Delete product
                                            Navigator.of(context).pop(); // Close dialog
                                          },
                                          child: Text('Delete'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductPage(
                onAddProduct: addProduct, // Pass the addProduct function
              ),
            ),
          );
        },
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: Icon(Icons.add),
      ),
    );
  }
}
