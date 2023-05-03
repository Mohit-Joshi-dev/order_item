// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:order_me/db_service.dart';
import 'package:order_me/models/item_model.dart';
import 'package:order_me/widgets/item_card.dart';

/// Cart View
class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  List<ItemModel> cartItems = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Cart'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : cartItems.isEmpty
              ? const Center(
                  child: Text(
                    'No Items Found!\nPlease add an Item in the Cart.',
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    return ItemCard(
                        item: cartItems[index],
                        inCart: true,
                        onTapCart: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await DBService()
                              .removeItemToCart(item: cartItems[index]);
                          init();
                        });
                  },
                ),
      bottomSheet: cartItems.isEmpty
          ? null
          : ElevatedButton(
              onPressed: () async {
                await DBService().emptyCart();
                init();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text('Order Placed'),
                  backgroundColor: Colors.green,
                ));
              },
              child: Container(
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text('Place Order')),
            ),
    );
  }

  init() async {
    setState(() {
      isLoading = true;
    });
    final items = await DBService().getCartItems();
    setState(() {
      cartItems = List.from(items);
      isLoading = false;
    });
  }
}
