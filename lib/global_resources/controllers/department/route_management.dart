import 'package:flutter/material.dart';

class RouteManagement {
  final QR_SCAN_SCREEN = 'QR scan';
  final Favorites = 'Favorites';
  final MY_ORDERS_SCREEN = 'My Orders';
  final INVENTORY_SCREEN = 'Inventory';
  final ORDERS_SCREEN = 'Orders';
  final PACKAGES_SCREEN = 'Packages';
  final TRANSIT_SCREEN = 'Transit';
  final MY_WALLET_SCREEN = 'My Wallet';
  final SETTINGS_SCREEN = 'Settings';
  final CONTACT_US_SCREEN = 'Contact Us';

  void routeToScreen({required BuildContext context, required Widget destination, bool forgetHistory = false}) {
    if (forgetHistory){
      Navigator.of(context).pushAndRemoveUntil(
//        context,
        PageRouteBuilder(
          transitionDuration:
          const Duration(milliseconds: 245),
          reverseTransitionDuration:
          const Duration(milliseconds: 245),
          pageBuilder: (context, animation,
              secondaryAnimation) =>
              FadeTransition(
                opacity: animation,
                child: destination,
              ),
        ),
            (route) => false,
      );
    }
    else {
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration:
          const Duration(milliseconds: 300),
          reverseTransitionDuration:
          const Duration(milliseconds: 300),
          pageBuilder: (context, animation,
              secondaryAnimation) =>
              FadeTransition(
                opacity: animation,
                child: destination,
              ),
        ),
      );
    }
  }
}