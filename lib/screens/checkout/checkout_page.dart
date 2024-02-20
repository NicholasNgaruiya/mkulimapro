

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../global_resources/controllers/sasa_controller.dart';
import 'components/checkout_appbar.dart';
import 'components/checkout_product_list.dart';
import 'components/checkout_product_totals.dart';
import 'components/checkout_product_widget.dart';
import 'model/checkout_model.dart';
//todo fragility and urgency and safety index for higher delivery
class CheckoutPage extends StatelessWidget {
  const CheckoutPage({Key? key}):super(key: key);
  @override
  Widget build(BuildContext context) {
    double mapHeight = MediaQuery.of(context).size.height/2;
    return Scaffold(
      appBar: CheckoutAppBar(title: 'Checkout',),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CheckoutProductList(),
            SizedBox(height: 10.0,),
            CheckoutProductTotals(),
            SizedBox(height: 10.0,),
          ],
        ),
      ),
    );
  }
}