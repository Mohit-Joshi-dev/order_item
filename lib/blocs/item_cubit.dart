import 'package:connectivity_wrapper/connectivity_wrapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:order_me/db_service.dart';
import 'package:order_me/models/models.dart';
import 'package:order_me/repo.dart';

part 'item_state.dart';

/// [ItemCubit] for state management and includes all [ItemState]
class ItemCubit extends Cubit<ItemState> {
  ItemCubit() : super(const ItemInitial());

  final Repo _repo = Repo();

  Future<void> getList() async {
    emit(const ItemLoading());
    final db = DBService();
    final isOnline = await ConnectivityWrapper.instance.isConnected;
    final cartItems = await db.getCartItems();
    if (isOnline) {
      try {
        List<ItemModel> items = await _repo.getList();
        await db.save(items: items);
        emit(ItemSuccess(
          items: items,
          cartItems: cartItems,
        ));
      } catch (e) {
        emit(ItemError(message: e.toString()));
      }
    } else {
      final items = await db.getItems();
      emit(ItemSuccess(
        items: items,
        cartItems: cartItems,
      ));
    }
  }
}
