import 'package:assignment13/services/api_services.dart';
import 'package:flutter/material.dart';

import '../../model/product.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});
  final Product product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _nameTEController = TextEditingController();
  final TextEditingController _productCodeTEController =
      TextEditingController();
  final TextEditingController _quantityTEController = TextEditingController();
  final TextEditingController _unitPriceTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final TextEditingController _imageTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late Map<String, dynamic> inputData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _nameTEController.text = widget.product.productName;
    _productCodeTEController.text = widget.product.productCode;
    _quantityTEController.text = widget.product.quantity;
    _unitPriceTEController.text = widget.product.unitPrice;
    _totalPriceTEController.text = widget.product.totalPrice;
    _imageTEController.text = widget.product.image;

    inputData = {
      "Img": widget.product.image,
      "ProductCode": widget.product.productCode,
      "ProductName": widget.product.productName,
      "Qty": widget.product.quantity,
      "TotalPrice": widget.product.totalPrice,
      "UnitPrice": widget.product.unitPrice,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameTEController,
                  decoration: const InputDecoration(
                    hintText: 'Product name',
                    labelText: 'Name',
                  ),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'product name is required';
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ApiServices.updateProduct(
                          inputData: inputData, productId: widget.product.id);
                    }
                    print('product id is:  ${widget.product.id}');
                  },
                  child: const Text('Update product'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _nameTEController.dispose();
    _productCodeTEController.dispose();
    _quantityTEController.dispose();
    _unitPriceTEController.dispose();
    _totalPriceTEController.dispose();
    _imageTEController.dispose();
  }
}
