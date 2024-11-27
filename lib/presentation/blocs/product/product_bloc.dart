import 'package:catalogue_project/core/constants.dart';
import 'package:catalogue_project/domain/models/product_category_model.dart';
import 'package:catalogue_project/domain/repositories/product_repository.dart';
import 'package:catalogue_project/presentation/blocs/product/product_event.dart';
import 'package:catalogue_project/presentation/blocs/product/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState>{

  final ProductRepository productRepo;

  int selectedCategoryIndex = 0;

  ProductBloc({required this.productRepo}) :super (ProductsLoading()) {
    on<FetchProductEvent>(_onFetchProductEvent);
    on<FetchProductCategoryEvent>(_onFetchProductCategoryEvent);
    on<SelectProductCategoryEvent>(_onSelectProductCategoryEvent);
  }

  _onFetchProductEvent(FetchProductEvent event, Emitter<ProductState> emit) async {

    emit(ProductsLoading());

    final products = await productRepo.getProducts(0);
    if(products.isEmpty) {
      emit(ProductsError(message: "Empty List"));
    }
    emit(ProductsLoaded(products: products));
  }

  _onSelectProductCategoryEvent(SelectProductCategoryEvent event, Emitter<ProductState> emit){
    emit(SelectedProductCategory(index: event.index));
  }

  _onFetchProductCategoryEvent(FetchProductCategoryEvent event, Emitter<ProductState> emit) async {
    emit(ProductCategoriesLoading());

    final categories = await productRepo.getProductCategories();
    if(categories.isEmpty) {
      emit(ProductsError(message: "Empty List"));
    }
    categories.insert(0, ProductCategoryModel(name: "All", url: baseUrl));
    emit(ProductCategoriesLoaded(categories: categories));
  }
    
}