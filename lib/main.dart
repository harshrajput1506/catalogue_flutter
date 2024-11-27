import 'package:catalogue_project/data/repositories/product_reposiotry_impl.dart';
import 'package:catalogue_project/domain/repositories/product_repository.dart';
import 'package:catalogue_project/presentation/blocs/product/product_bloc.dart';
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider<ProductRepository>(
        create: (context) => ProductRepositoryImpl(), 
        child: MultiBlocProvider(
          providers: [
            BlocProvider<ProductBloc>(create: (context) => ProductBloc(productRepo: context.read<ProductRepository>())),
          ],
          child: const ProductScreen()
          ),
        )
    );
  }
}
