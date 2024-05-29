import 'package:assignment13/services/api_services.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final TextEditingController nameTEController = TextEditingController();
  final TextEditingController _productCodeTEController =
      TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: nameTEController,
                  decoration: const InputDecoration(
                    hintText: 'Product name',
                    labelText: 'Name',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Product name is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _productCodeTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Product code',
                    labelText: 'Product code',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Product Code is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _quantityTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Quantity',
                    labelText: 'Quantity',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Quantity is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _unitPriceTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Unit price ',
                    labelText: 'Unit price',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'unit price is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _totalPriceTEController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    hintText: 'Total price ',
                    labelText: 'Total price',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Total is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: _imageTEController,
                  decoration: const InputDecoration(
                    hintText: 'Image link ',
                    labelText: 'Image link',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Image link is required';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var productData = {
                        "ProductName": nameTEController.text.trim(),
                        "ProductCode": _productCodeTEController.text.trim(),
                        "Img": _imageTEController.text.trim(),
                        "UnitPrice": _unitPriceTEController.text.trim(),
                        "Qty": _quantityTEController.text.trim(),
                        "TotalPrice": _totalPriceTEController.text.trim(),
                      };

                      try {
                        final response =
                            await ApiServices.addProduct(productData);
                      } catch (error) {
                        print('Failed to add product');
                      } finally {
                        _clearFormFields();
                      }
                    }
                  },
                  child: const Text('Add product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _clearFormFields() {
    nameTEController.clear();
    _productCodeTEController.clear();
    _quantityTEController.clear();
    _unitPriceTEController.clear();
    _totalPriceTEController.clear();
    _imageTEController.clear();
  }

  @override
  void dispose() {
    super.dispose();
    nameTEController.dispose();
    _productCodeTEController.dispose();
    _quantityTEController.dispose();
    _unitPriceTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
  }
}
