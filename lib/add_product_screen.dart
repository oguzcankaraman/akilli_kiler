import 'package:akilli_kiler/pantry_item.dart';
import 'package:flutter/material.dart';

class AddProductScreen extends StatefulWidget {
  final Function(PantryItem) addProduct;
  const AddProductScreen({super.key,required this.addProduct});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final controller = TextEditingController();

  DateTime? selectedDate;

  void setSelectedDate(DateTime? date) {
    setState(() {
      selectedDate = date;
    });
  }

  DateTime? getSelectedDate() {
    return selectedDate;
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
                onPressed: () async {
                  final DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2030),
                  );

                  if (pickedDate != null) {
                    setSelectedDate(pickedDate);
                  }
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
                            : '${getSelectedDate()!.day}/${getSelectedDate()!.month}/${getSelectedDate()!.year}',
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
                    final DateTime? selectedDate = getSelectedDate();
                    late DateTime expiryDate;
                    if (productName.isNotEmpty) {
                      if (selectedDate == null) {
                        expiryDate = DateTime.now().add(const Duration(days: 7));
                      }
                      else {
                        expiryDate = selectedDate;
                      }
                      final newProduct = PantryItem(
                        name: productName,
                        expiryDate: expiryDate
                      );
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
