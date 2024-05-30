import 'package:assignment13/model/product.dart';
import 'package:assignment13/services/api_services.dart';
import 'package:assignment13/view/add_product_screen/add_product_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../update_product_screen/update_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddProductScreen(),
              ));
        },
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _refreshProduct,
        color: Colors.white,
        backgroundColor: Colors.green,
        child: FutureBuilder(
          future: ApiServices.getProductFromApi(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.isEmpty) {
              return const Center(
                child: Text('No product found'),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.separated(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final product = snapshot.data![index];
                  return ListTile(
                    leading: CachedNetworkImage(
                      imageUrl: product.image,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.scaleDown,
                      width: 75,
                    ),
                    title: Text(
                      product.productName,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Wrap(
                      spacing: 5,
                      children: [
                        Text(
                          'Unit Price: ${product.unitPrice}',
                        ),
                        Text(
                          'Product Code: ${product.productCode}',
                        ),
                        Text(
                          'Total Price: ${product.totalPrice}',
                        ),
                      ],
                    ),
                    trailing: Wrap(
                      spacing: 4,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateProductScreen(
                                  product: product,
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit),
                          color: Colors.black,
                        ),
                        IconButton(
                          onPressed: () {
                            return showDeleteConfirmation(product.id);
                          },
                          icon: const Icon(Icons.delete_sharp),
                          color: Colors.red,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              );
            } else {
              return const Text('No data found');
            }
          },
        ),
      ),
    );
  }

  Future<void> _refreshProduct() async {
    try {
      final data = await ApiServices.getProductFromApi();
      setState(() {
        productList = data;
      });
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error fetching products: $error'),
        ),
      );
    }
  }

  void showDeleteConfirmation(productId) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Warning!'),
            content: const Text('Are you want to delete this product?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () {
                    ApiServices.deleteProduct(productId);
                    Navigator.pop(context);
                    _refreshProduct();
                  },
                  child: const Text('Yes, delete!')),
            ],
          );
        });
  }
}
