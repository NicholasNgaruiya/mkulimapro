// import 'package:agrisasa/global_resources/controllers/department/security.dart';
// import 'package:agrisasa/global_resources/extensions/bool_extensions.dart';
//
// import '../../../global_resources/controllers/sasa_controller.dart';
// import '../../../global_resources/models/Product.dart';
// import '../../../global_resources/models/sasa_object.dart';
// import 'package:collection/collection.dart';
//
// enum CheckOutItemState {singleItem, package, both}
// class CheckoutModel extends SasaObject {
//   CheckoutModel({required this.product,this.quantity=1,required this.unitPrice, required this.checkOutItemState, this.packageName = '', required this.upperStockLimit, this.sellingAsSingleOrPackage = false});
//   final Product product;
//   int quantity;
//   final List<int> upperStockLimit;
//   final List<double> unitPrice;
//   CheckOutItemState checkOutItemState;
//   final String packageName;
//   final bool sellingAsSingleOrPackage;
//
//   @override
//   String get distinguishingKey => product.distinguishingKey;
//   @override
//   String get distinguishingValue => product.distinguishingValue;
//
//   @override
//   Map<String, dynamic> toMap() {
//     return {
//       'quantity'.encode(): quantity.encode(),
//       'unitPriceSingle'.encode(): unitPrice[0].encode(),
//       if (sellingAsSingleOrPackage) 'unitPriceSingleOrPackage'.encode(): unitPrice[1].encode(),
//       'upperStockLimitSingle'.encode(): upperStockLimit[0].encode(),
//       if (sellingAsSingleOrPackage) 'upperStockLimitSingleOrPackage'.encode(): upperStockLimit[1].encode(),
//       'checkOutItemState'.encode(): checkOutItemState.toString().encode(),
//       'packageName'.encode(): packageName.encode(),
//       'sellingAsSingleOrPackage'.encode(): '$sellingAsSingleOrPackage'.encode(),
//       ...product.toMap(),
//     };
//   }
//   @override
//   fromMap(Map<String, dynamic> data) {
//     String str = (data['checkOutItemState'.encode()] as String).decode();
//     CheckOutItemState checkOutItemState = CheckOutItemState.values.firstWhere((e) {
//       SasaController.feedbackManagement.verbose('enum value: $e', screenContext: 'CheckoutModel', verboseType: 'DEBUG');
//       return e.toString() == str;
//     });
//     bool singleOrPackage = (data['sellingAsSingleOrPackage'.encode()] as String).decode().parseBool();
//     List<double> unitPrices = singleOrPackage?
//         [
//           (data['unitPriceSingle'.encode()] as double).decode(),
//           (data['unitPriceSingleOrPackage'.encode()] as double).decode()
//         ]
//         :
//         [
//           (data['unitPriceSingle'.encode()] as double).decode()
//         ];
//     List<int> upperStockLimits = singleOrPackage?
//     [
//       (data['upperStockLimitSingle'.encode()]  as int).decode(),
//       (data['upperStockLimitSingleOrPackage'.encode()]  as int).decode(),
//     ]
//         :
//     [
//       (data['upperStockLimitSingle'.encode()]  as int).decode(),
//     ];
//     return CheckoutModel(
//         quantity: (data['quantity'.encode()] as int).decode(),
//         unitPrice: unitPrices,
//         upperStockLimit: upperStockLimits,
//         packageName: (data['packageName'.encode()] as String).decode(),
//         sellingAsSingleOrPackage: singleOrPackage,
//         checkOutItemState: checkOutItemState,
//         product: product.fromMap(data));
//   }
//   @override
//   bool operator ==(Object other) {
//     Function eq = const ListEquality().equals;
//     bool value = other is CheckoutModel &&
//         quantity == other.quantity &&
//         eq(unitPrice , other.unitPrice) &&
//         eq(upperStockLimit, other.upperStockLimit) &&
//         checkOutItemState == other.checkOutItemState &&
//         packageName == other.packageName &&
//         sellingAsSingleOrPackage == other.sellingAsSingleOrPackage &&
//         product == other.product;
//     if (value)SasaController.feedbackManagement.verbose('this; ${toMap()} vs ${other.toMap()}', screenContext: 'ProductCardModel', verboseType: 'DEBUG');
//     return value;
//   }
//
//
//   @override
//   // TODO: implement hashCode
//   int get hashCode => getHashCode(quantity, unitPrice)^getHashCode(getHashCode(checkOutItemState,upperStockLimit), getHashCode(packageName,getHashCode(sellingAsSingleOrPackage, product)));
//   int getHashCode(s1,s2) {
//     return s1.hashCode^s2.hashCode;
//   }
// }