import 'package:crypto_asset_tracker/data/categories.dart';
import 'package:crypto_asset_tracker/models/my_asset.dart';
import 'package:crypto_asset_tracker/models/category.dart';

final myDummyAssets = [
  MyAsset(
      id: '1',
      name: 'BTC',
      quantity: 1,
      buyPrice: 30000,
      category: categories[Categories.layer1]!),
  MyAsset(
      id: '2',
      name: 'ETH',
      quantity: 10,
      buyPrice: 2000,
      category: categories[Categories.layer1]!),
  MyAsset(
      id: '3',
      name: 'DOGE',
      quantity: 1000,
      buyPrice: 1,
      category: categories[Categories.meme]!),
];
