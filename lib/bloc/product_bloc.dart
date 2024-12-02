import 'package:bloc/bloc.dart';
import 'package:product_list/product_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<FetchProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        final response =
            await http.get(Uri.parse('https://dummyjson.com/products'));

        if (response.statusCode == 200) {
          List<Product> products =
              (json.decode(response.body)['products'] as List)
                  .map((product) => Product.fromJson(product))
                  .toList();

          emit(ProductLoaded(products));
        } else {
          emit(ProductError('Failed to load products.'));
        }
      } catch (e) {
        emit(ProductError('An error occurred: ${e.toString()}'));
      }
    });
  }
}
