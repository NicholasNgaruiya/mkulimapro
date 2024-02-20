import 'package:flutter/material.dart';

class RecomendPlantCard extends StatelessWidget {
  const RecomendPlantCard({
    Key? key,
    required this.image,
    required this.title,
    required this.country,
    required this.price,
    required this.press,
  }) : super(key: key);

  final String image, title, country;
  final String price;
  final void Function() press;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.teal),
      ),
      // color: Colors.green[50],
      margin: const EdgeInsets.only(
        // left: 10.0,
        top: 20.0 / 2,
        bottom: 10.0 * 2.5,
      ),
      // width: size.width * 0.4,
      child: Stack(
        children: [
          Column(
            children: <Widget>[
              Image.asset(
                image,
                width: double.infinity,
                fit: BoxFit.fitHeight,
                height: 70,
              ),
              GestureDetector(
                onTap: press,
                child: Container(
                  padding: const EdgeInsets.all(20.0 / 2),
                  decoration: BoxDecoration(
                    color: Colors.green[50],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    // boxShadow: [
                    //   BoxShadow(
                    //     offset: Offset(0, 10),
                    //     blurRadius: 50,
                    //     color: kPrimaryColor.withOpacity(0.23),
                    //   ),
                    // ],
                    /*
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0C9869)
                            .withOpacity(0.23), // Shadow color
                        spreadRadius: 5, // Spread radius
                        blurRadius: 50, // Blur radius
                        offset: const Offset(0, 10),
                      ),
                    ],
                    */
                  ),
                  child: Row(
                    children: <Widget>[
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "$title\n".toUpperCase(),
                                style: Theme.of(context).textTheme.labelLarge),
                            TextSpan(
                              text: country.toUpperCase(),
                              style: TextStyle(
                                color: const Color(0xFF0C9869).withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Text(
                        'Ksh.$price',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(color: const Color(0xFF0C9869)),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          Align(
              alignment: Alignment.topRight,
              child: IconButton(
                color: Colors.teal,
                onPressed: press,
                icon: const Icon(Icons.add_shopping_cart),
              ))
        ],
      ),
    );
  }
}
