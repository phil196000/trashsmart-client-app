import 'package:stacked/stacked.dart';
import 'package:trashsmart/core/models/product.dart';

import 'package:trashsmart/core/services/products.service.dart';
import 'package:trashsmart/app/locator.dart';

class MarketViewModel extends ReactiveViewModel {
  // You can use get_it service locator or pass it in through the constructor
  final ProductService _informationService = locator<ProductService>();

  MarketViewModel() {
    print("Initialized");
  }

  List<Product> get popularProducts => _informationService.products;

  // <Product>[
  //       new Product(
  //         name: 'Dustbins',
  //         price: 12.0,
  //         description:
  //             "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
  //         image:
  //             "https://images.unsplash.com/photo-1559060472-b08c4724c934?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1267&q=80",
  //       ),
  //       new Product(
  //         name: 'Brushes',
  //         price: 12.0,
  //         description:
  //             "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
  //         image:
  //             "https://images.unsplash.com/photo-1559060472-b08c4724c934?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1267&q=80",
  //       ),
  //       new Product(
  //         name: 'Mobs',
  //         price: 12.0,
  //         description:
  //             "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
  //         image:
  //             "https://images.unsplash.com/photo-1559060472-b08c4724c934?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1267&q=80",
  //       ),
  //       new Product(
  //         name: 'Sprayers',
  //         price: 12.0,
  //         description:
  //             "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum",
  //         image:
  //             "https://images.unsplash.com/photo-1559060472-b08c4724c934?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1267&q=80",
  //       ),
  //     ];

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_informationService];
}
