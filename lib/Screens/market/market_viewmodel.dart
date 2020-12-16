import 'package:stacked/stacked.dart';
import 'package:trashsmart/core/models/product.dart';

import 'package:trashsmart/core/services/products.service.dart';
import 'package:trashsmart/app/locator.dart';

class MarketViewModel extends ReactiveViewModel {
  // You can use get_it service locator or pass it in through the constructor
  final ProductService _informationService = locator<ProductService>();
  List<Product> products = [];

  MarketViewModel() {
    getProducts();
  }

  void getProducts() {
    setBusy(true);
    products = _informationService.products;
    setBusy(false);
  }

  List<Product> get popularProducts => products;

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_informationService];
}
