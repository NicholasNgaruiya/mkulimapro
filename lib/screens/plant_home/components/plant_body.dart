import 'package:flutter/material.dart';
import '../../../constants.dart';

import 'featurred_plants.dart';
import 'header_with_seachbox.dart';
import 'recomend_plants.dart';
import 'title_with_more_bbtn.dart';

class PlantBody extends StatelessWidget {
  const PlantBody({super.key});

  final defaultPadding = 20.0;
  @override
  Widget build(BuildContext context) {
    // It will provie us total height  and width of our screen
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small device
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        HeaderWithSearchBox(size: size),
        TitleWithMoreBtn(title: "Products", press: () {}),
        Expanded(
          child: GridView.builder(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.only(
              right: kDefaultPadding,
              bottom: kDefaultPadding,
            ),
            itemCount: 7,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              mainAxisSpacing: defaultPadding,
              crossAxisSpacing: defaultPadding,
            ),
            itemBuilder: (context, index) {
              return RecomendPlantCard(
                image: "assets/images/image_3.png",
                title: "Samantha",
                country: "Russia",
                price: 440,
                press: () {},
              );
            },
          )
        ),

      ],
    );
  }
}
