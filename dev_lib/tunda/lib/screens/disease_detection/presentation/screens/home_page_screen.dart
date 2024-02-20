import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunda/screens/disease_detection/cart/bloc/cart_bloc.dart';
import 'package:tunda/screens/disease_detection/cart/cart_item.dart';
import 'package:tunda/screens/disease_detection/cart/cart_page.dart';
import 'package:tunda/screens/disease_detection/presentation/bloc/fruit_tester_bloc.dart';
import 'package:tunda/screens/disease_detection/presentation/bloc_observer.dart';
import 'package:tunda/screens/disease_detection/presentation/fungicides/bloc/recommended_fungicides_bloc.dart';
import 'package:tunda/screens/disease_detection/presentation/fungicides/repository/fungicide_repository.dart';
// import 'package:tunda/presentation/widgets/tunda_widget.dart';
import 'package:tunda/screens/disease_detection/presentation/widgets/tunda_widget.dart';

class DiseaseDetectionPage extends StatefulWidget {
  const DiseaseDetectionPage({super.key});

  @override
  State<DiseaseDetectionPage> createState() => _DiseaseDetectionPageState();
}

class _DiseaseDetectionPageState extends State<DiseaseDetectionPage> {
  final List<CartItem> cartItems = []; // Define cart items list
  late final CartBloc cartBloc;

  @override
  void initState() {
    super.initState();

    cartBloc = CartBloc();
  }

  @override
  Widget build(BuildContext context) {
    Bloc.observer = AppGlobalBlocObserver();

    final fungicideRepository = FungicideRepository();

    final recommendedFungicidesBloc =
        RecommendedFungicidesBloc(fungicideRepository);
    final fruitTesterBloc =
        FruitTesterBloc(recommendedFungicidesBloc: recommendedFungicidesBloc);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => fruitTesterBloc),
        BlocProvider(create: (context) => recommendedFungicidesBloc),
        BlocProvider(create: (context) => cartBloc),
      ],
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Disease Detection'),
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {},
            ),
            actions: [
              IconButton(
                // icon: const Icon(Icons.add_shopping_cart),
                icon: const Icon(Icons.shopping_cart),
                onPressed: () {
                  //Navigate to the cart page
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => BlocProvider.value(
                                value: cartBloc,
                                child: const CartPage(),
                              )));
                },
              ),
            ],
          ),
          body: const TundaWidget()),
      // MaterialApp(
      //   debugShowCheckedModeBanner: false,
      //   home: DiseaseDetectionPage(),
      // ),
    );
  }

  @override
  void dispose() {
    cartBloc.close();
    super.dispose();
  }
}
