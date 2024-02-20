import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mkulimapro/components/my_bottom_nav_bar.dart';

import '../../constants.dart';
import 'components/plant_body.dart';

class PlantHomeScreen extends StatelessWidget {
  const PlantHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: PlantBody(),
      // bottomNavigationBar: MyBottomNavBar(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: kPrimaryColor,
      leading: IconButton(
        icon: SvgPicture.asset("assets/icons/menu.svg"),
        onPressed: () {},
      ),
    );
  }
}
