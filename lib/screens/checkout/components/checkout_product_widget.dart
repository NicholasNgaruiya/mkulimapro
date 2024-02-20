// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:flutter/material.dart';
import '../../../global_resources/controllers/sasa_controller.dart';
import '../controllers/checkout_page_controller.dart';
import '../model/checkout_model.dart';
import 'rounded_bordered_container.dart';
import 'typography.dart';

class CheckoutProductWidget extends StatelessWidget {
  const CheckoutProductWidget({
    Key? key,
    required this.index,
  }) : super(key: key);
  final int index;
  // final CheckoutModel checkOutModel;
  // final ValueChanged<CheckoutModel> onAddOrSubtractQuantityUpdate;
  // final ValueChanged<CheckOutItemState?> onCheckOutItemStateSelection;

  @override
  Widget build(BuildContext context) {
    var subTotal = 100.0;
    return RoundedContainer(
      padding: const EdgeInsets.all(0),
      margin: EdgeInsets.all(10),
//      height: 130,
      child: Row(
        children: <Widget>[
          Container(
            width: 130,
            height: 130,
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/image_3.png'),
                  fit: BoxFit.cover,
                )),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Frank',
                          overflow: TextOverflow.fade,
                          softWrap: true,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                    Row(
                      children: <Widget>[
                        Text("Price: "),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '\$20.00',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Text("Sub Total: "),
                        SizedBox(
                          width: 5,
                        ),
                        Text('\$$subTotal',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w300,
                              color: Colors.orange,
                            ))
                      ],
                    ),
                  Row(
                    children: <Widget>[
                      Text(
                        "Quantity",
                        style: TextStyle(color: Colors.orange),
                      ),
                      Spacer(),
                      Row(
                        children: <Widget>[
                          InkWell(
                            onTap: () {

                            },
                            splashColor: Colors.redAccent.shade200,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(
                                  Icons.remove,
                                  color: Colors.redAccent,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('1'),
                            ),
                          ),
                          SizedBox(
                            width: 4,
                          ),
                          InkWell(
                            onTap: () {
                            },
                            splashColor: Colors.lightBlue,
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50)),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.green,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

  }
}