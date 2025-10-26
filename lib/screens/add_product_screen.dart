import 'package:akilli_kiler/helpers/pantry_item.dart';
import 'package:flutter/material.dart';

import '../constants/app_color.dart';

class AddProductScreen extends StatefulWidget {
  final Function(PantryItem) addProduct;

  const AddProductScreen({super.key, required this.addProduct});

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
        backgroundColor: Theme.of(context).colorScheme.primary,
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
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(AppColors.primary),
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
                  width: 230,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                          Icons.calendar_today,
                          color: AppColors.iconDefault),
                      const SizedBox(width: 10),
                      Text(
                        getSelectedDate() == null
                            ? 'Son Kullanma Tarihi Seçiniz'
                            : '${getSelectedDate()!.day}/${getSelectedDate()!.month}/${getSelectedDate()!.year}',
                        style: TextStyle(color: AppColors.textPrimary),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.all(
                    AppColors.buttonGreen,
                  ),
                ),
                onPressed: () {
                  final String productName = controller.text;
                  final DateTime? selectedDate = getSelectedDate();
                  late DateTime expiryDate;
                  if (productName.isNotEmpty) {
                    if (selectedDate == null) {
                      expiryDate = DateTime.now().add(const Duration(days: 7));
                    } else {
                      expiryDate = selectedDate;
                    }
                    final newProduct = PantryItem(
                      name: productName,
                      expiryDate: expiryDate,
                    );
                    widget.addProduct(newProduct);
                  }
                  Navigator.pop(context);
                },
                child: const Text(
                  'Kaydet',
                  style: TextStyle(color: AppColors.textPrimary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
