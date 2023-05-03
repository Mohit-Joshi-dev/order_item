import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:order_me/blocs/blocs.dart';

import 'views/views.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ItemCubit>(
      create: (context) => ItemCubit(),
      child: ConnectivityAppWrapper(
        app: MaterialApp(
          title: 'Order Me',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const SplashView(),
        ),
      ),
    );
  }
}
