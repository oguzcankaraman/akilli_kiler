import 'package:flutter/material.dart';
import 'package:akilli_kiler/screens/add_product_screen.dart';
import 'package:akilli_kiler/helpers/pantry_item.dart';
import '../constants/app_color.dart';
import '../services/database_service.dart';

class CellarListScreen extends StatefulWidget {
  const CellarListScreen({super.key});

  @override
  State<CellarListScreen> createState() => CellarListScreenState();
}

class CellarListScreenState extends State<CellarListScreen> {
  final List<PantryItem> products = [];
  final DatabaseService _dbService = DatabaseService.instance;
  late bool _isAscending = true;

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final loadedProducts = await _dbService.getPantryItems();
    setState(() {
      products.clear();
      products.addAll(loadedProducts);
      _sortProducts();
    });
  }

  void addProduct(PantryItem newProduct) async {
    await _dbService.addPantryItem(newProduct);
    await _loadProducts();
  }

  Future<void> _deleteProduct(int id) async {
    await _dbService.deletePantryItem(id);
    await _loadProducts();
  }

  void _sortProducts() {
    setState(() {
      products.sort(
        (a, b) => _isAscending
            ? a.expiryDate.compareTo(b.expiryDate)
            : b.expiryDate.compareTo(a.expiryDate),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold, bir ekranın temel görsel yapısını (başlık çubuğu, gövde vb.) sağlar.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dolabım'),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              _isAscending = !_isAscending;
              _sortProducts();
            },
          ),
        ],
      ),
      body: products.isNotEmpty
          ? ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(products[index].id.toString()),
                  background: Container(
                    color: AppColors.error,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: AppColors.background),
                  ),
                  secondaryBackground: Container(
                    color: AppColors.error,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: AppColors.background),
                  ),
                  confirmDismiss: (direction) async {
                    return await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Onay"),
                          content: const Text(
                            "Bu ürünü silmek istediğinizden emin misiniz?",
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text(
                                "İPTAL",
                                style: TextStyle(color: AppColors.textPrimary),
                              ),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text(
                                  "SİL",
                                  style: TextStyle(color: AppColors.error),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  onDismissed: (direction) {
                    _deleteProduct(products[index].id!);
                  },
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.fastfood),
                      title: Text(products[index].name),
                      trailing: Builder(
                        builder: (context) {
                          final daysLeft = products[index].expiryDate
                              .difference(DateTime.now())
                              .inDays;
                          String message;
                          Color textColor;

                          if (daysLeft < 0) {
                            message = 'Süresi doldu';
                            textColor = Color(0xFFD50000);
                          } else if (daysLeft == 0) {
                            message = 'Son gün';
                            textColor = Colors.red;
                          } else if (daysLeft <= 3) {
                            message = '$daysLeft gün sonra tarihi doluyor';
                            textColor = Color(0xFFFF8A65);
                          } else {
                            message = '$daysLeft gün içinde tüketmelisiniz';
                            textColor = Colors.green;
                          }

                          return Text(
                            message,
                            style: TextStyle(color: textColor),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'Kileriniz boş. Ürün eklemek için "+" butonuna tıklayın.',
                textAlign: TextAlign.center,
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddProductScreen(addProduct: addProduct),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
