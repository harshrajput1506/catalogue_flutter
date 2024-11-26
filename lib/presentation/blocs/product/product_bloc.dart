import 'dart:async';

import 'package:catalogue_project/data/repositories/product_reposiotry_impl.dart';
import 'package:catalogue_project/presentation/blocs/product/product_event.dart';
import 'package:catalogue_project/presentation/blocs/product/product_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState>{

  final ProductRepositoryImpl productRepo;

  ProductBloc({required this.productRepo}) :super (ProductsLoading()) {
    on<FetchProductEvent>(_onFetchProductEvent);
  }

  _onFetchProductEvent(FetchProductEvent event, Emitter<ProductState> emitter) async* {
    

  }
    
}