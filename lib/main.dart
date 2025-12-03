import 'package:flutter/material.dart';
import 'models/product.dart';
import 'services/product_service.dart';

void main() {
  runApp(ProductListApp());
}

class ProductListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Product List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ProductListPage(),
    );
  }
}

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<List<Product>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = ProductService().fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Product List'),
      ),
      body: FutureBuilder<List<Product>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final products = snapshot.data!;
            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return ListTile(
                  leading: product.img.isNotEmpty
                      ? Image.network(product.img, width: 50, height: 50)
                      : Icon(Icons.image_not_supported),
                  title: Text(product.productName),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Product Code: ${product.productCode}'),
                      Text('Quantity: ${product.qty}'),
                      Text('Unit Price: \$${product.unitPrice}'),
                      Text('Total Price: \$${product.totalPrice}'),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No products available'));
          }
        },
      ),
    );
  }
}
