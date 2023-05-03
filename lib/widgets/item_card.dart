import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:order_me/models/models.dart';

/// [ItemCard] for showings items in a list widget
class ItemCard extends StatelessWidget {
  const ItemCard({
    super.key,
    required this.item,
    required this.onTapCart,
    this.inCart = false,
  });

  final ItemModel item;
  final bool inCart;
  final Function onTapCart;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          CachedNetworkImage(
            imageUrl: item.strMealThumb,
            height: 100,
            width: MediaQuery.of(context).size.width - 10,
            fit: BoxFit.cover,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Text(item.strMeal),
              ),
              IconButton(
                  onPressed: () => onTapCart(),
                  icon: Icon(
                    inCart ? Icons.shopping_bag : Icons.shopping_bag_outlined,
                    color: Colors.blue,
                  ))
            ],
          ),
        ],
      ),
    );
  }
}
