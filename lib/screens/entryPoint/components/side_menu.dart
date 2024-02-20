import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

import '../../../global_resources/controllers/sasa_controller.dart';
import '../../../model/menu.dart';
import '../controller/entry_point_controller.dart';

enum AssetUse { useRive, useIcon }

class SideMenu extends StatefulWidget {
  const SideMenu(
      {super.key,
      required this.menu,
      required this.press,
      required this.riveOnInit,
      this.assetUse = AssetUse.useRive,
      this.icon,
      required this.onFinishBuild,
      required this.mpEntryPointController});

  final Menu menu;
  final VoidCallback press;
  final ValueChanged<Artboard> riveOnInit;
  final MPEntryPointController mpEntryPointController;
  final AssetUse assetUse;
  final IconData? icon;
  final VoidCallback onFinishBuild;
  @override
  State<SideMenu> createState() => _SideBarState();
}

class _SideBarState extends State<SideMenu> {
  @override
  void initState() {
    // TODO: implement initState
    SasaController.stateManagement.addStateListener(
        widgetName:
            '${SasaController.stateManagement.MP_SIDE_MENU}_${widget.menu.title}',
        onStateChange: (stateTrigger) {
          SasaController.feedbackManagement.verbose('onStateChange',
              screenContext: 'MP_SIDE_MENU', verboseType: 'DEBUG');
          setState(() {
            stateTrigger();
          });
        });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SasaController.stateManagement.removeStateListener(
        widgetName:
            '${SasaController.stateManagement.MP_SIDE_MENU}_${widget.menu.title}');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 24),
          child: Divider(color: Colors.white24, height: 1),
        ),
        Stack(
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 300),
              curve: Curves.fastOutSlowIn,
              width: widget.mpEntryPointController.mPSideBarController
                          .selectedSideMenu ==
                      widget.menu
                  ? 288
                  : 0,
              height: 56,
              left: 0,
              child: Container(
                decoration: const BoxDecoration(
                  // color: Color(0xFF6792FF),
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
            ),
            ListTile(
              onTap: widget.press,
              leading: SizedBox(
                height: 36,
                width: 36,
                child: widget.assetUse == AssetUse.useRive
                    ? RiveAnimation.asset(
                        widget.menu.rive.src,
                        artboard: widget.menu.rive.artboard,
                        onInit: widget.riveOnInit,
                      )
                    : Icon(widget.icon!),
              ),
              title: Text(
                widget.menu.title,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
