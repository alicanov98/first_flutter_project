import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:ornek_proje/models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductsModel? _products;
  List<Product> _productsArr = [];

  void _loadData() async {
    final dataString = await rootBundle.loadString('assets/files/data.json');
    final dataJson = jsonDecode(dataString);

    _products = ProductsModel.fromJson(dataJson);
    _productsArr = _products!.products;
    setState(() {});
  }

  void _filterData(int id) {
    _productsArr = _products!.products
        .where((itemsProduct) => itemsProduct.kategori == id)
        .toList();
    setState(() {});
  }

  void _resetData() {
    _productsArr = _products!.products;
    setState(() {});
  }

  @override
  void initState() {
    _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: _products == null
                ? const Text('Loading...')
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          onPressed: _resetData,
                          child: const Text('All Products')),
                      _kategoriViwe(),
                      _productView()
                    ],
                  )));
  }

  ListView _productView() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: _productsArr.length,
      itemBuilder: (context, index) {
        final Product item = _productsArr[index];
        return ListTile(
            leading: Image.network(
              item.resim,
              width: 50,
              height: 100,
              fit: BoxFit.cover,
            ),
            title: Text(item.isim));
      },
      separatorBuilder: (context, index) => const Divider(
        height: 10,
      ),
    );
  }

  Row _kategoriViwe() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_products!.kategoriler.length, (index) {
        final kategori = _products!.kategoriler[index];
        return GestureDetector(
          onTap: () => _filterData(kategori.id),
          child: Container(
            padding: const EdgeInsets.all(8),
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.black12, borderRadius: BorderRadius.circular(10)),
            child: Text(_products!.kategoriler[index].isim),
          ),
        );
      }),
    );
  }
}
