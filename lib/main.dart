import 'package:flutter/material.dart';
import 'package:akilli_kiler/cellar_list_screen.dart';
import 'package:akilli_kiler/constants/app_color.dart';

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
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.background,
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          tertiary: AppColors.tertiary,
        ),
        fontFamily: 'Poppins',
        useMaterial3: true,
        datePickerTheme: DatePickerThemeData(
          headerBackgroundColor: AppColors.primary,
          headerForegroundColor: AppColors.textPrimary,
          backgroundColor: AppColors.background,
          dayForegroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.textPrimary;
            }
            return AppColors.textPrimary;
          }),
          dayBackgroundColor: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return AppColors.buttonPrimary;
            }
            return null;
          }),
          todayBackgroundColor: WidgetStateProperty.all(AppColors.secondary),
          todayForegroundColor: WidgetStateProperty.all(AppColors.textPrimary),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(AppColors.buttonPrimary),
          ),
        ),
        iconTheme: IconThemeData(
          color: AppColors.iconDefault,
        )
      ),

      home: const CellarListScreen(),
    );
  }
}
