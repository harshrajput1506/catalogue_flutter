import 'package:catalogue_project/data/repositories/product_reposiotry_impl.dart';
import 'package:catalogue_project/domain/repositories/product_repository.dart';
import 'package:catalogue_project/presentation/blocs/cart/cart_bloc.dart';
import 'package:catalogue_project/presentation/blocs/product/product_bloc.dart';
import 'package:catalogue_project/presentation/screens/cart_screen.dart';
import 'package:catalogue_project/presentation/screens/products_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<ProductRepository>(
      create: (context) => ProductRepositoryImpl(),
      child: MultiBlocProvider(
          providers: [
            BlocProvider<ProductBloc>(
                create: (context) => ProductBloc(
                    productRepo: context.read<ProductRepository>())),
            BlocProvider<CartBloc>(create: (context) => CartBloc()),
          ],
          child: const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: ProductScreen(),
          )),
    );
  }
}
