import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  final Function(Map) addProduct;
  const AddProductScreen({super.key,required this.addProduct});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ürün Ekleme Ekranı'),
        backgroundColor: Colors.green[100],
      ),
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 5.0,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Ürün Adı Giriniz',
                ),
              ),
              ElevatedButton(
                onPressed: null,
                child: Text('Son kullanma tarihi seçiniz'),
              ),
              ElevatedButton(
                  onPressed: () {
                    final String urunAdi = controller.text;
                    if (urunAdi.isNotEmpty) {
                      final newProduct = {
                        'item': urunAdi,
                        'date': '17/11/2025' // Sabit tarih
                      };
                      widget.addProduct(newProduct);
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Kaydet')),
            ],
          ),
        ),
      ),
    );
  }
}
