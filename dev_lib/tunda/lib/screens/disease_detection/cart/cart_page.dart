import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tunda/screens/disease_detection/cart/bloc/cart_bloc.dart';
import 'package:tunda/screens/disease_detection/cart/cart_item.dart';

class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoaded) {
            final List<CartItem> cartItems = state.cartItems;
            double totalCost = 0;
            for (var item in cartItems) {
              totalCost += double.parse(item.price);
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final CartItem cartItem = cartItems[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 16.0,
                        ),
                        child: ListTile(
                          leading: Image.asset(
                            cartItem.image,
                            width: 60,
                            height: 60,
                          ),
                          title: Text(
                            cartItem.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text('Price: ${cartItem.price}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_shopping_cart),
                            onPressed: () {
                              context
                                  .read<CartBloc>()
                                  .add(RemoveFromCartEvent(cartItem));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${cartItem.name} removed from cart'),
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Total Cost: $totalCost',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
