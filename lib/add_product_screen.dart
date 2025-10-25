import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddProductScreen extends StatefulWidget {
  final Function(Map) addProduct;
  const AddProductScreen({super.key,required this.addProduct});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final controller = TextEditingController();

  Future<DateTime>? selectedDate;

  void setSelectedDate(Future<DateTime>? date) {
    setState(() {
      selectedDate = date;
    });
  }

  String? getSelectedDate() {
    return DateFormat('dd/MM/yyyy')
        .format(DateTime.now().add(const Duration(days: 7)));
  }

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
                style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xFFA5D6A7))
                ),
                onPressed: () {
                  Future<DateTime>? selectedDate = showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2030),
                  ) as Future<DateTime>?;
                  setSelectedDate(selectedDate);
                },
                child: SizedBox(
                  width: 220,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.calendar_today),
                      const SizedBox(width: 10),
                      Text(
                        getSelectedDate() == null
                            ? 'Son Kullanma Tarihi Seçiniz'
                            : '${getSelectedDate()}',
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Color(0xFFA5D6A7))
                  ),
                  onPressed: () {
                    final String productName = controller.text;
                    if (productName.isNotEmpty) {
                      final newProduct = {
                        'item': productName,
                        'date': getSelectedDate(),
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
