import 'package:flutter/material.dart';
import 'package:akilli_kiler/add_product_screen.dart';
import 'package:akilli_kiler/pantry_item.dart';

class CellarListScreen extends StatefulWidget {
  const CellarListScreen({super.key});

  @override
  State<CellarListScreen> createState() => CellarListScreenState();
}

class CellarListScreenState extends State<CellarListScreen> {
  final List<PantryItem> products = [];

  void addProduct(PantryItem newProduct) {
    setState(() {
      products.add(newProduct);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold, bir ekranın temel görsel yapısını (başlık çubuğu, gövde vb.) sağlar.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kilerim'),
        backgroundColor: Colors.green[100],
      ),
      body: products.isNotEmpty
          ? ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon(Icons.fastfood),
                  title: Text(products[index].name),
                  trailing: Text('${products[index].expiryDate.difference(DateTime.now()).inDays} gün içinde tüketmelisiniz'),
                );
              },
            )
          : Center(
              child: Text(
                'Kileriniz boş. Ürün eklemek için "+" butonuna tıklayın.',
                style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddProductScreen(addProduct: addProduct)),
          );
        },
        backgroundColor: Colors.green[200],
        child: const Icon(Icons.add),
      ),
    );
  }
}
