import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_me/blocs/blocs.dart';
import 'package:order_me/db_service.dart';
import 'package:order_me/views/views.dart';
import 'package:order_me/widgets/widgets.dart';

/// Home View
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Me'),
        actions: [
          IconButton(
            onPressed: onTapCart,
            icon: const Icon(Icons.shopping_cart),
          )
        ],
      ),
      // checks for network
      body: ConnectivityWidgetWrapper(
        message: 'Please connect to Internet!',
        color: Colors.red,
        child: BlocBuilder<ItemCubit, ItemState>(
          builder: (context, state) {
            if (state is ItemLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is ItemSuccess) {
              return ListView.builder(
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final item = state.items[index];
                  final inCart = state.cartItems
                      .any((element) => element.idMeal == item.idMeal);
                  return ItemCard(
                    item: item,
                    inCart: inCart,
                    onTapCart: () async {
                      if (inCart) {
                        await DBService().removeItemToCart(item: item);
                      } else {
                        await DBService().addItemToCart(item: item);
                      }

                      // ignore: use_build_context_synchronously
                      context.read<ItemCubit>().getList();
                    },
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  onTapCart() {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const CartView(),
        )).then((value) => context.read<ItemCubit>().getList());
  }
}
