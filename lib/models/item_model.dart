import 'package:json_annotation/json_annotation.dart';

part 'item_model.g.dart';

@JsonSerializable()
class ItemModel {
  ItemModel({
    this.strMeal = '',
    this.strMealThumb = '',
    this.idMeal = '',
  });

  factory ItemModel.fromJson(Map<String, dynamic> json) =>
      _$ItemModelFromJson(json);

  String strMeal, strMealThumb, idMeal;

  Map<String, dynamic> toJson() => _$ItemModelToJson(this);

  List<Object> get props => [
        strMeal,
        strMealThumb,
        idMeal,
      ];
}
