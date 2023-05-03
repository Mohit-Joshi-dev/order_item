part of 'item_cubit.dart';

abstract class ItemState extends Equatable {
  const ItemState();
}

class ItemInitial extends ItemState {
  const ItemInitial();

  @override
  List<Object> get props => [];
}

class ItemLoading extends ItemState {
  const ItemLoading();

  @override
  List<Object> get props => [];
}

class ItemError extends ItemState {
  const ItemError({
    required this.message,
  });

  final String message;

  @override
  List<Object> get props => [message];
}

class ItemSuccess extends ItemState {
  const ItemSuccess({
    required this.items,
    required this.cartItems,
  });

  final List<ItemModel> items;
  final List<ItemModel> cartItems;

  @override
  List<Object> get props => [items];
}
