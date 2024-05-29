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
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
    setState(() {});
  }

  Future<void> fetchData() async {
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
      print('Error fetching products: $error');
    }
  }

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
        child: Visibility(
          visible: productList.isNotEmpty,
          replacement: const Center(child: CircularProgressIndicator()),
          child: ListView.separated(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CachedNetworkImage(
                  imageUrl: productList[index].image ?? '',
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fit: BoxFit.scaleDown,
                  width: 75,
                ),
                title: Text(
                  productList[index].productName ?? '',
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Wrap(
                  spacing: 5,
                  children: [
                    Text(
                      'Unit Price: ${productList[index].unitPrice ?? ''}',
                    ),
                    Text(
                      'Product Code: ${productList[index].productCode ?? ''}',
                    ),
                    Text(
                      'Total Price: ${productList[index].totalPrice ?? ''}',
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
                              product: productList[index],
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.edit),
                      color: Colors.black,
                    ),
                    IconButton(
                      onPressed: () {
                        return showDeleteConfirmation();
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
          ),
        ),
      ),
    );
  }

  Future<void> _refreshProduct() async {
    try {
      productList.clear();
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

  void showDeleteConfirmation() {
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
                    Navigator.pop(context);
                  },
                  child: const Text('Yes, delete!')),
            ],
          );
        });
  }
}
