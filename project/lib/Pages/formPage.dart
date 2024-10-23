// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_const_constructors_in_immutables, use_key_in_widget_constructors, unnecessary_nullable_for_final_variable_declarations, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class AddProductPage extends StatefulWidget {
  final Function(Product) onAddProduct; // Function to add product

  AddProductPage({required this.onAddProduct}); // Constructor with required parameter

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  String? _productName;
  String? _price;
  File? _image;

  final picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveProduct() async {
    if (_formKey.currentState!.validate() && _image != null) {
      _formKey.currentState!.save();

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final List<String>? existingProducts = prefs.getStringList('products') ?? [];

      // Preventing duplicacy based on product name
      if (existingProducts!.any((product) => json.decode(product)['name'] == _productName)) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Product already exists!'),
        ));
        return;
      }

      final newProduct = json.encode({
        'name': _productName,
        'price': _price,
        'imagePath': _image!.path,
      });

      existingProducts.add(newProduct);
      await prefs.setStringList('products', existingProducts);

      // Trigger the callback to pass the new product to the homepage
      widget.onAddProduct(Product(
        name: _productName!,
        price: double.parse(_price!),
        imagePath: _image!.path,
      ));

      Navigator.pop(context); // Go back to HomePage after saving
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Product')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Product Name'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => _productName = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
                onSaved: (value) => _price = value,
              ),
              SizedBox(height: 20),
              _image == null
                  ? Text('No image selected')
                  : Image.file(_image!, height: 100),
              ElevatedButton(
                onPressed: _pickImage,
                child: Text('Pick Image from Gallery'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProduct,
                child: Text('Add Product'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  final String imagePath;

  Product({
    required this.name,
    required this.price,
    required this.imagePath,
  });
}
