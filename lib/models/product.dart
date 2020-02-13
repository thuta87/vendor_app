class Product {
  int product_id;
  String product_name;
  String description;
  String image;
  int category_id;
  int collection_id;
  String tags;
  int original_price;
  int retail_price;
  String sku;
  String barcode;
  int negative_qty;
  int is_physical;
  int weight;

  Product(
      {this.product_id, this.product_name, this.description, this.image, this.category_id, this.collection_id, this.tags, this.original_price, this.retail_price, this.sku, this.barcode, this.negative_qty, this.is_physical, this.weight});

  factory Product.fromJson(Map<dynamic, dynamic> json) {
    return Product(
      product_id: json['product_id'] as int,
      product_name: json['product_name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      category_id: json['category_id'] as int,
      collection_id: json['collection_id'] as int,
      tags: json['tags'] as String,
      original_price: json['orinial_p'] as int,
      retail_price: json['retail_price'] as int,
      sku: json['sku'] as String,
      barcode: json['barcode'] as String,
      negative_qty: json['negative_qty'] as int,
      is_physical: json['is_physical'] as int,
      weight: json['weight'] as int
    );
  }
}