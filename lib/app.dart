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
          seedColor: Colors.deepOrange,
          dynamicSchemeVariant: DynamicSchemeVariant.vibrant,
          brightness: Brightness.light,
        ),

        indicatorColor: Colors.deepOrange,
        inputDecorationTheme: InputDecorationTheme(
          prefixIconColor: Colors.deepOrange,
          hintStyle: const TextStyle(color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Colors.deepOrange),
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
            backgroundColor: Colors.deepOrange,
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
              return const BorderSide(color: Colors.deepOrange);
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
                return Colors.deepOrange;
              }
              return Colors.transparent;
            },
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          unselectedItemColor: Colors.grey,
          selectedItemColor: Colors.deepOrange,
          backgroundColor: Colors.white,
        ),
        iconTheme: IconThemeData(
          color: Colors.deepOrange,
        ),
        cardTheme: CardTheme(
          elevation: 2,
          surfaceTintColor: Colors.deepOrange[100],
        ),
        
        

      ),
      routerConfig: AppRouter().router,
    );
  }
}
