import 'dart:math';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:mkulimapro/global_resources/models/user_account.dart';
import 'package:rive/rive.dart';
import 'package:mkulimapro/constants.dart';
import 'package:mkulimapro/screens/home/home_screen.dart';
import 'package:mkulimapro/utils/rive_utils.dart';

import '../../global_resources/controllers/sasa_controller.dart';
import '../../model/menu.dart';
import '../plant_home/plant_home_screen.dart';
import 'components/btm_nav_item.dart';
import 'components/menu_btn.dart';
import 'components/side_bar.dart';
import 'components/widget_switch.dart';
import 'controller/entry_point_controller.dart';

class EntryPoint extends StatefulWidget {
  const EntryPoint({super.key, required this.cameras, required this.userAccount});
  final List<CameraDescription>cameras;
  final UserAccount userAccount;
  @override
  State<EntryPoint> createState() => _EntryPointState();
}

class _EntryPointState extends State<EntryPoint>
    with SingleTickerProviderStateMixin {
  final mpEntryPointController = MPEntryPointController();
  

  Menu selectedBottonNav = bottomNavItems.first;
  Menu selectedSideMenu = sidebarMenus.first;

  void updateSelectedBtmNav(Menu menu) {
    if (selectedBottonNav != menu) {
      setState(() {
        selectedBottonNav = menu;
      });
    }
  }
  @override
  void initState() {
    mpEntryPointController.animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200))
      ..addListener(
        () {
          setState(() {});
        },
      );
    mpEntryPointController.scalAnimation = Tween<double>(begin: 1, end: 0.8).animate(CurvedAnimation(
        parent: mpEntryPointController.animationController, curve: Curves.fastOutSlowIn));
    mpEntryPointController.animation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
        parent: mpEntryPointController.animationController, curve: Curves.fastOutSlowIn));
    SasaController.stateManagement.addStateListener(
        widgetName: SasaController.stateManagement.ENTRY_POINT,
        onStateChange: (stateTrigger){
          SasaController.feedbackManagement.verbose('onStateChange', screenContext: 'ENTRY_POINT', verboseType: 'DEBUG');
          setState(() {
            stateTrigger();
          });
        }
    );
    super.initState();
  }

  @override
  void dispose() {
    mpEntryPointController.animationController.dispose();
    SasaController.stateManagement.removeStateListener(widgetName: SasaController.stateManagement.ENTRY_POINT);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor2,
      body: Stack(
        children: [
          AnimatedPositioned(
            width: 288,
            height: MediaQuery.of(context).size.height,
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: mpEntryPointController.isSideBarOpen ? 0 : -288,
            top: 0,
            child: SideBar(
              mpEntryPointController: mpEntryPointController,
              cameras: widget.cameras,
              userAccount: widget.userAccount,
              animationController: mpEntryPointController.animationController,
            ),
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(
                  1 * mpEntryPointController.animation.value - 30 * (mpEntryPointController.animation.value) * pi / 180),
            child: Transform.translate(
              offset: Offset(mpEntryPointController.animation.value * 265, 0),
              child: Transform.scale(
                scale: mpEntryPointController.scalAnimation.value,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(24),
                  ),
                  child: MPWidgetSwitcher(
                    mpEntryPointController: mpEntryPointController,
                    cameras: widget.cameras,
                    userAccount: widget.userAccount,
                  ),
                  // child: PlantHomeScreen(),
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: const Duration(milliseconds: 200),
            curve: Curves.fastOutSlowIn,
            left: mpEntryPointController.isSideBarOpen ? 220 : 0,
            top: 16,
            child: MenuBtn(
              press: mpEntryPointController.onMenuPress,
              riveOnInit: (artboard) {
                final controller = StateMachineController.fromArtboard(
                    artboard, "State Machine");

                artboard.addController(controller!);

                mpEntryPointController.isMenuOpenInput =
                controller.findInput<bool>("isOpen") as SMIBool;
                mpEntryPointController.isMenuOpenInput.value = true;
              },
            ),
          ),
        ],
      ),
    );
  }
}
