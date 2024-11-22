import 'package:flutter/material.dart';
import 'package:crypto_asset_tracker/data/dummy_assets.dart';
import 'package:crypto_asset_tracker/models/my_asset.dart';
import 'crypto_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<MyAsset> _assetList = [];

  @override
  void initState() {
    _assetList.addAll(myDummyAssets);
    super.initState();
  }

  void _addAsset(MyAsset newAsset) {
    setState(() {
      _assetList.add(newAsset);
    });
  }

  List<MyAsset> _combineAssets(List<MyAsset> assets) {
    final Map<String, MyAsset> combinedMap = {};

    for (var asset in assets) {
      if (combinedMap.containsKey(asset.name)) {
        final existing = combinedMap[asset.name]!;
        final totalQuantity = existing.quantity + asset.quantity;
        final avgPrice = ((existing.buyPrice * existing.quantity) +
                (asset.buyPrice * asset.quantity)) /
            totalQuantity;
        combinedMap[asset.name] = MyAsset(
          id: existing.id,
          name: asset.name,
          quantity: totalQuantity,
          buyPrice: avgPrice,
          category: asset.category,
        );
      } else {
        combinedMap[asset.name] = asset;
      }
    }

    return combinedMap.values.toList();
  }

  @override
  Widget build(BuildContext context) {
    final combinedAssets = _combineAssets(_assetList);

    Widget content = const Center(
      child: Text(
        'No data',
      ),
    );

    if (combinedAssets.isNotEmpty) {
      content = ListView.builder(
        itemCount: combinedAssets.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(combinedAssets[index].name),
            subtitle: Text('${combinedAssets[index].quantity} units'),
            leading: Container(
              width: 24,
              height: 24,
              color: combinedAssets[index].category.color,
            ),
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text('Average Price'),
                Text('\$${combinedAssets[index].buyPrice.toStringAsFixed(2)}'),
              ],
            ),
          );
        },
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crypto Asset Tracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final newAsset = await Navigator.push<MyAsset>(
                context,
                MaterialPageRoute(
                  builder: (context) => const AddCryptoScreen(),
                ),
              );
              if (newAsset != null) {
                _addAsset(newAsset);
              }
            },
          ),
        ],
      ),
      body: content,
    );
  }
}
