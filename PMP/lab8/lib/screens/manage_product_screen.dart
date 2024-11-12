import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/product.dart';

class ManageProductsScreen extends StatefulWidget {
  @override
  _ManageProductsScreenState createState() => _ManageProductsScreenState();
}

class _ManageProductsScreenState extends State<ManageProductsScreen> {
  late Box<Product> productBox;
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    productBox = Hive.box<Product>('productBox');
  }

  void _addProduct() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final name = _nameController.text;
                final description = _descriptionController.text;
                final price = double.tryParse(_priceController.text) ?? 0.0;

                if (name.isNotEmpty && description.isNotEmpty) {
                  final newProduct = Product(
                    id: DateTime.now().toString(),
                    name: name,
                    description: description,
                    price: price,
                  );
                  productBox.add(newProduct);
                  _nameController.clear();
                  _descriptionController.clear();
                  _priceController.clear();
                  Navigator.pop(context);
                  setState(() {});
                }
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  void _editProduct(int index, Product product) {
    _nameController.text = product.name;
    _descriptionController.text = product.description;
    _priceController.text = product.price.toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Product'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: _priceController,
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                final updatedName = _nameController.text;
                final updatedDescription = _descriptionController.text;
                final updatedPrice = double.tryParse(_priceController.text) ?? product.price;

                if (updatedName.isNotEmpty && updatedDescription.isNotEmpty) {
                  productBox.putAt(index, Product(
                    id: product.id,
                    name: updatedName,
                    description: updatedDescription,
                    price: updatedPrice,
                  ));
                  _nameController.clear();
                  _descriptionController.clear();
                  _priceController.clear();
                  Navigator.pop(context);
                  setState(() {});
                }
              },
              child: Text('Save'),
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
        title: Text('Manage Products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _addProduct,
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: productBox.length,
        itemBuilder: (context, index) {
          final product = productBox.getAt(index);
          return ListTile(
            title: Text(product!.name),
            subtitle: Text('${product.description} - \$${product.price.toStringAsFixed(2)}'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () => _editProduct(index, product),
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    productBox.deleteAt(index);
                    setState(() {});
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
