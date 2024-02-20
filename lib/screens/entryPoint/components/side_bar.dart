import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../../global_resources/controllers/sasa_controller.dart';
import '../../../global_resources/models/user_account.dart';
import '../../../model/menu.dart';
import '../../../model/rive_model.dart';
import '../../../utils/rive_utils.dart';
import '../controller/entry_point_controller.dart';
import 'info_card.dart';
import 'side_menu.dart';

class SideBar extends StatefulWidget {
  const SideBar(
      {super.key,
      required this.mpEntryPointController,
      required this.cameras,
      required this.userAccount,
      required this.animationController});
  final MPEntryPointController mpEntryPointController;
  final List<CameraDescription> cameras;
  final UserAccount userAccount;
  final AnimationController animationController;

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    var logoutMenu = Menu(
      title: "Log out",
      rive: RiveModel(
          src: "assets/RiveAssets/icons.riv",
          artboard: "CHAT",
          stateMachineName: "CHAT_Interactivity"),
    );
    return SafeArea(
      child: Container(
        width: 288,
        height: double.infinity,
        decoration: const BoxDecoration(
          // color: Color(0xFF17203A),
          color: Colors.teal,
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
        ),
        child: DefaultTextStyle(
          style: const TextStyle(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoCard(
                name: widget.userAccount.firstName,
                bio: "",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 32, bottom: 16),
                child: Text(
                  "".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...sidebarMenus
                  .map((menu) => SideMenu(
                        menu: menu,
                        onFinishBuild: () {},
                        mpEntryPointController: widget.mpEntryPointController,
                        press: () {
                          RiveUtils.chnageSMIBoolState(menu.rive.status!);
                          widget.mpEntryPointController.mPSideBarController
                              .updateMenuStatus(
                                  menu: menu,
                                  mpEntryPointController:
                                      widget.mpEntryPointController);
                          // setState(() {
                          //   widget.mpEntryPointController.mPSideBarController.selectedSideMenu = menu;
                          // });
                          // widget.mpEntryPointController.onMenuPress();
                        },
                        riveOnInit: (artboard) {
                          menu.rive.status = RiveUtils.getRiveInput(artboard,
                              stateMachineName: menu.rive.stateMachineName);
                        },
                      ))
                  .toList(),
              Padding(
                padding: const EdgeInsets.only(left: 24, top: 40, bottom: 16),
                child: Text(
                  "".toUpperCase(),
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium!
                      .copyWith(color: Colors.white70),
                ),
              ),
              ...sidebarMenus2
                  .map((menu) => SideMenu(
                        menu: menu,
                        mpEntryPointController: widget.mpEntryPointController,
                        onFinishBuild: () {},
                        press: () {
                          RiveUtils.chnageSMIBoolState(menu.rive.status!);
                          widget.mpEntryPointController.mPSideBarController
                              .updateMenuStatus(
                                  menu: menu,
                                  mpEntryPointController:
                                      widget.mpEntryPointController);
                          // setState(() {
                          //   widget.mpEntryPointController.mPSideBarController.selectedSideMenu = menu;
                          // });
                          // widget.mpEntryPointController.onMenuPress();
                        },
                        riveOnInit: (artboard) {
                          menu.rive.status = RiveUtils.getRiveInput(artboard,
                              stateMachineName: menu.rive.stateMachineName);
                        },
                      ))
                  .toList(),
              SideMenu(
                menu: logoutMenu,
                assetUse: AssetUse.useIcon,
                mpEntryPointController: widget.mpEntryPointController,
                icon: Icons.logout,
                onFinishBuild: () {},
                press: () {
                  // RiveUtils.chnageSMIBoolState(menu.rive.status!);
                  // widget.mpEntryPointController.mPSideBarController.updateMenuStatus(menu: logoutMenu,ignore: true,mpEntryPointController: );
                  Future.delayed(const Duration(milliseconds: 300), () {
                    //proceed to next
                    SasaController.dataFlow.logoutUserLocally(
                        context: context, cameras: widget.cameras);
                  });
                  // setState(() {
                  //   widget.mpEntryPointController.mPSideBarController.selectedSideMenu = menu;
                  // });
                },
                riveOnInit: (artboard) {
                  // menu.rive.status = RiveUtils.getRiveInput(artboard,
                  //     stateMachineName: menu.rive.stateMachineName);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
