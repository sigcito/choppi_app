import 'package:flutter/material.dart';
import 'package:choppi_app/auth/auth_wrapper.dart';
import 'package:choppi_app/config/app_config.dart';
import 'package:choppi_app/login.dart';
import 'package:choppi_app/views/store_products.dart';
import 'package:choppi_app/views/stores.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await AppConfig.initialize();

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthWrapper(),
      routes: {
        'login': (context) => MyLogin(),
        'stores': (context) => StoresWidget(),
        'store_products': (context) => StoreProducts(storeId: 0),
      },
    ),
  );
}
