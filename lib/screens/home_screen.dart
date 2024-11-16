import 'package:flutter/material.dart';
import 'package:crypto_asset_tracker/data/dummy_assets.dart';
import 'package:crypto_asset_tracker/models/my_asset.dart';

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

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text(
        'No data',
      ),
    );

    if (_assetList.isNotEmpty) {
      content = ListView.builder(
        itemCount: _assetList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_assetList[index].name),
            subtitle: Text(_assetList[index].quantity.toString()),
            leading: Container(
              width: 24,
              height: 24,
              color: _assetList[index].category.color,
            ),
            trailing: Column(
              children: [
                const Text('Average Price'),
                Text('\$${_assetList[index].buyPrice.toString()}'),
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
            onPressed: () {},
          ),
        ],
      ),
      body: content,
    );
  }
}
