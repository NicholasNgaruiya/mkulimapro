import '../../../global_resources/controllers/sasa_controller.dart';
import '../../../model/menu.dart';
import 'entry_point_controller.dart';

class MPSideBarController {
  Menu selectedSideMenu = sidebarMenus.first;
  Menu previousSideMenu = sidebarMenus.first;
  void updateMenuStatus({required Menu menu, bool ignore = false, required MPEntryPointController mpEntryPointController}) {
    SasaController.stateManagement.setStateFromStateListener(
        statefulWidgets: [
          '${SasaController.stateManagement.MP_SIDE_MENU}_${menu.title}',
          '${SasaController.stateManagement.MP_SIDE_MENU}_${previousSideMenu.title}',
          if (!ignore)SasaController.stateManagement.MP_WIDGET_SWITCH,
        ],
        stateTrigger: (){
          selectedSideMenu = menu;
        }
    );
    previousSideMenu = selectedSideMenu;
    Future.delayed(const Duration(milliseconds: 300), () {
      //proceed to next
      mpEntryPointController.onMenuPress();

    });

  }
}