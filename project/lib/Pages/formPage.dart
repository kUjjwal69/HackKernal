// add_product_page.dart
// ignore_for_file: prefer_const_constructors, no_leading_underscores_for_local_identifiers

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project/products.dart';
// Import your product model

class AddProductPage extends StatefulWidget {
  final Function(Product) onAddProduct; // Function to add product

  AddProductPage({required this.onAddProduct}); // Constructor

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  File? _image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Product'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a product name';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a price';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16.0),
              _image == null
                  ? Text('No image selected.')
                  : Image.file(
                      _image!,
                      height: 100,
                      width: 100,
                    ),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Create a Product object
                    final product = Product(
                      name: _nameController.text,
                      price: double.parse(_priceController.text),
                      imagePath: _image!.path,
                    );

                    widget.onAddProduct(product); // Call the add product function
                    Navigator.pop(context); // Close the page
                  }
                },
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();

    // Use the gallery or camera option
    final XFile? image = await _picker.pickImage(
      source: ImageSource.gallery, // Allows selection from gallery
      imageQuality: 100, // You can adjust quality if needed
    );

    if (image != null) {
      setState(() {
        _image = File(image.path); // Set the selected image
      });
    }
  }
}
