import '../model/checkout_model.dart';
import 'checkout_product_widget_controller.dart';
import 'checkout_product_totals_controller.dart';

class CheckoutPageController {
//
  String vendorName = 'Rupa shopping mall';
  List<double> vendorLocationLatLong = [0.5143606, 35.2910491];
//  final checkoutProductController = CheckoutProductController();
  List<CheckoutProductWidgetController> checkoutProductWidgetControllers = [];
  final checkoutProductTotalsController = CheckoutProductTotalsController();
}