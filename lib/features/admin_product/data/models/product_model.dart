class ProductModel {
  String? id;
  String? sellerId;
  String? productCode;
  String? name;
  String? description;
  String? nameArabic;
  String? descriptionArabic;
  String? coverPictureUrl;
  int? price;
  int? stock;
  int? weight;
  String? color;
  int? discountPercentage;
  List<String>? categories;

  ProductModel({
    this.id,
    this.sellerId,
    this.productCode,
    this.name,
    this.description,
    this.nameArabic,
    this.descriptionArabic,
    this.coverPictureUrl,
    this.price,
    this.stock,
    this.weight,
    this.color,
    this.discountPercentage,
    this.categories,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id']?.toString();
    sellerId = json['sellerId']?.toString();
    productCode = json['productCode']?.toString();
    name = json['name']?.toString();
    description = json['description']?.toString();
    nameArabic = (json['nameArabic'] ?? json['arabicName'] ?? json['nameAr'])?.toString();
    descriptionArabic = (json['descriptionArabic'] ?? json['arabicDescription'] ?? json['descriptionAr'])?.toString();
    coverPictureUrl = json['coverPictureUrl']?.toString();
    price = (json['price'] as num?)?.toInt();
    stock = (json['stock'] as num?)?.toInt();
    weight = (json['weight'] as num?)?.toInt();
    color = json['color']?.toString();
    discountPercentage = (json['discountPercentage'] as num?)?.toInt();
    if (json['categories'] != null) {
      categories = List<String>.from(json['categories'].map((v) => v.toString()));
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'sellerId': sellerId ?? "d051dbf3-f5d8-410d-0e50-08de06562562",
      'productCode': productCode ?? "PRD-${DateTime.now().millisecondsSinceEpoch}",
      'name': name,
      'description': description,
      'nameArabic': nameArabic,
      'descriptionArabic': descriptionArabic,
      'coverPictureUrl': coverPictureUrl ?? "https://images.unsplash.com/photo-1535632066927-ab7c9ab60908",
      'price': price,
      'stock': stock,
      'weight': weight ?? 150,
      'color': color ?? "Gold",
      'discountPercentage': discountPercentage ?? 0,
      'categoryIds': [], 
    };
  }
}
