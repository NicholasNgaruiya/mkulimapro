
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mkulimapro/global_resources/extensions/double_extensions.dart';
import '../../../global_resources/controllers/sasa_controller.dart';
import '../model/checkout_model.dart';
import 'rounded_bordered_container.dart';
import 'typography.dart';

class CheckoutProductTotals extends StatelessWidget {
  const CheckoutProductTotals({
    Key? key,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var subTotal = 100.00;
    var deliveryFee = 10.00;
    var systemFee = (((deliveryFee+subTotal)*0.01)+7.50).toPrecision(2);//consider financial institution rates
    var total = subTotal + deliveryFee + systemFee;
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(blurRadius: 5.0,color: Colors.grey.shade700),
        ],
        color: Colors.white,
      ),
      padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0, bottom: 10.0),
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Subtotal"),
              Text("\$$subTotal"),
            ],
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Delivery fee"),
              Text("\$$deliveryFee"),
            ],
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("System fee"),
              Text("\$$systemFee"),
            ],
          ),
          SizedBox(height: 10.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Total",style: TextStyle(fontWeight: FontWeight.bold),),
              Text("\$$total",style: TextStyle(fontWeight: FontWeight.bold),),
            ],
          ),
          SizedBox(height: 10.0,),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: (){},
              child: Text("CHECKOUT"),
            ),
          )
        ],
      ),
    );


  }
}