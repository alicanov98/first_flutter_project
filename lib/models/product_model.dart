class ProductsModel {
  final List<Product> products;
  final List<Kategori> kategoriler;
  ProductsModel(this.kategoriler, this.products);

  factory ProductsModel.fromJson(Map<String, dynamic> json) {
    final List jsonProduct = json['urunler'];
    final List jsonKategori = json['kategoriler'];

    return ProductsModel(jsonKategori.map((e) => Kategori.fromJson(e)).toList(),
        jsonProduct.map((e) => Product.json(e)).toList());
  }
}

class Product {
  final int id;
  final int kategori;
  final String isim;
  final String resim;
  Product(this.isim, this.resim, this.id, this.kategori);
  Product.json(Map<String, dynamic> json)
      : id = json['id'],
        kategori = json['kategori'],
        isim = json['isim'],
        resim = json['resim'];
}

class Kategori {
  final int id;
  final String isim;
  Kategori(this.id, this.isim);

  Kategori.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        isim = json['isim'];
}
