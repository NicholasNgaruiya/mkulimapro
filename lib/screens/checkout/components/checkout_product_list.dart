
import 'package:flutter/material.dart';
import '../controllers/checkout_page_controller.dart';
import '../model/checkout_model.dart';
import 'checkout_product_widget.dart';

class CheckoutProductList extends StatelessWidget {
  const CheckoutProductList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemCount: 7,
        itemBuilder: (BuildContext context, int index) {
          return CheckoutProductWidget(
            index: index,
          );
        }
    );
  }
}