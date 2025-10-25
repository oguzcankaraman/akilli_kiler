import 'package:flutter/material.dart';
import 'package:akilli_kiler/cellar_list_screen.dart';

// Her Flutter uygulaması bu main() fonksiyonundan başlar.
void main() {
  runApp(const AkilliKilerApp());
}

// Bu widget, uygulamamızın tamamını kapsayan ana çerçevedir.
class AkilliKilerApp extends StatelessWidget {
  const AkilliKilerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Akıllı Kiler',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0x000F0000)),
        useMaterial3: true,
      ),
      home: const CellarListScreen(),

    );
  }
}