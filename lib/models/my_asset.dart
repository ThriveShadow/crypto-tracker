import 'package:crypto_asset_tracker/models/category.dart';

class MyAsset {
  MyAsset({
    required this.id,
    required this.name,
    required this.quantity,
    required this.buyPrice,
    required this.category,
  });

  final String id;
  final String name;
  final double quantity;
  final double buyPrice;
  final Category category;
}