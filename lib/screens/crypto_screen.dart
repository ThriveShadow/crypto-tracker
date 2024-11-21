import 'package:flutter/material.dart';
import 'package:crypto_asset_tracker/models/my_asset.dart';
import 'package:crypto_asset_tracker/models/category.dart';
import 'package:crypto_asset_tracker/data/categories.dart';

class AddCryptoScreen extends StatefulWidget {
  const AddCryptoScreen({super.key});

  @override
  State<AddCryptoScreen> createState() => _AddCryptoScreenState();
}

class _AddCryptoScreenState extends State<AddCryptoScreen> {
  final _formKey = GlobalKey<FormState>();
  final String _id = UniqueKey().toString();
  String _name = '';
  double _quantity = 0.0;
  double _buyPrice = 0.0;

  final List<Category> _categories = categories.values.toList();

  Category? _selectedCategory;

  void _resetForm() {
    setState(() {
      _formKey.currentState?.reset();
      _name = '';
      _quantity = 0.0;
      _buyPrice = 0.0;
      _selectedCategory = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a New Asset'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Asset Name'),
                TextFormField(
                  decoration: const InputDecoration(
                    counterText: '',
                  ),
                  maxLength: 50,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the asset name.';
                    }
                    return null;
                  },
                  onSaved: (value) {

                    _name = value!;
                  },
                ),
                const SizedBox(height: 16),
                const Text('Quantity'),
                const SizedBox(height: 3),

                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value == null || double.tryParse(value) == null) {
                                return 'Invalid quantity.';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _quantity = double.parse(value!);
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<Category>(
                        decoration: const InputDecoration(
                        ),
                        items: _categories.map((category) {
                          return DropdownMenuItem(
                            value: category,
                            child: Row(
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  color: category.color,
                                  margin: const EdgeInsets.only(right: 8),
                                ),
                                Text(category.title),
                              ],
                            ),
                          );
                        }).toList(),
                        value: _selectedCategory,
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value;
                          });
                        },
                        validator: (value) {
                          if (value == null) {
                            return 'Select a category.';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                const Text(
                  'Buy Price'
                ),
                TextFormField(
                  decoration: const InputDecoration(),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || double.tryParse(value) == null) {
                      return 'Please enter a valid buy price.';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _buyPrice = double.parse(value!);
                  },
                ),
                const SizedBox(height: 32),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: _resetForm,
                      child: const Text('Reset'),
                    ),
                    const SizedBox(width: 15),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          final newAsset = MyAsset(
                            id: _id,
                            name: _name,
                            quantity: _quantity,
                            buyPrice: _buyPrice,
                            category: _selectedCategory!,
                          );
                          Navigator.pop(context, newAsset);
                        }
                      },
                      child: const Text('Add Item'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
