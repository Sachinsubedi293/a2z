import 'package:a2zjewelry/router/app_router.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {

  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'a2zjewelry',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.red,
          dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
          brightness: Brightness.light,
        ),

        indicatorColor: Colors.red,
        inputDecorationTheme: InputDecorationTheme(
          prefixIconColor: Colors.red,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.red),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.grey),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent,
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4.0),
          ),
          side: WidgetStateBorderSide.resolveWith(
            (states) {
              if (!states.contains(WidgetState.selected)) {
                return const BorderSide(color: Colors.brown);
              }
              return const BorderSide(color: Colors.red);
            },
          ),
          checkColor: WidgetStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.white;
              }
              return Colors.transparent;
            },
          ),
          fillColor: WidgetStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return Colors.red;
              }
              return Colors.transparent;
            },
          ),
        ),
      ),
      routerConfig: AppRouter().router,
    );
  }
}
