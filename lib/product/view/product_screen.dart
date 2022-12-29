import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/common/component/pagination_list_view.dart';
import 'package:flutter_delivery_app/product/model/product_model.dart';
import 'package:flutter_delivery_app/product/provider/product_provider.dart';
import 'package:flutter_delivery_app/product/component/product_card.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PaginationListView<ProductModel>(
      provider: productProvider,
      itemBuilder: <ProductModel>(_, index, model) {
        return ProductCard.fromProductModel(
          model: model,
        );
      },
    );
  }
}
