import 'package:assignment13/utils/theme/theme.dart';
import 'package:flutter/material.dart';

import '../product_list_screen/product_list_screen.dart';

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: SAppTheme.lightTheme,
      home: ProductListScreen(),
    );
  }
}
