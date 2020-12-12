import 'package:stacked/stacked.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trashsmart/core/models/product.dart';
import 'package:observable_ish/value/value.dart';
import 'package:stacked/stacked.dart';

class ProductService with ReactiveServiceMixin {
  Query query = FirebaseFirestore.instance.collection('market');

  //2
  RxValue<List<Product>> _products = RxValue<List<Product>>(initial: []);

  List<Product> get products => _products.value;

  ProductService() {
    listenToReactiveValues([_products]);
    FirebaseFirestore.instance.collection("market").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
        dynamic newRes = result.data();
        // print(""+newRes["price"].toString());
        _products.value.add(
          new Product(
            name: newRes["title"],
            description: newRes["description"],
            image: newRes["image_url"],
            stock: newRes["stock"],
            // price: double.parse(newRes["price"]),
          ),
        );
      });
    });
  }

  getAllProducts() {}
}
