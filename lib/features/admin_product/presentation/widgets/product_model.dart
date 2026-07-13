class Product {
  String? _id;
  String? _sellerId;
  String? _productCode;
  String? _name;
  String? _description;
  String? _nameArabic;
  String? _descriptionArabic;
  String? _coverPictureUrl;
  int? _price;
  int? _stock;
  int? _weight;
  String? _color;
  int? _discountPercentage;
  List<Categories>? _categories;
  List<Pictures>? _pictures;

  Product(
      {String? id,
      String? sellerId,
      String? productCode,
      String? name,
      String? description,
      String? nameArabic,
      String? descriptionArabic,
      String? coverPictureUrl,
      int? price,
      int? stock,
      int? weight,
      String? color,
      int? discountPercentage,
      List<Categories>? categories,
      List<Pictures>? pictures}) {
    if (id != null) {
      this._id = id;
    }
    if (sellerId != null) {
      this._sellerId = sellerId;
    }
    if (productCode != null) {
      this._productCode = productCode;
    }
    if (name != null) {
      this._name = name;
    }
    if (description != null) {
      this._description = description;
    }
    if (nameArabic != null) {
      this._nameArabic = nameArabic;
    }
    if (descriptionArabic != null) {
      this._descriptionArabic = descriptionArabic;
    }
    if (coverPictureUrl != null) {
      this._coverPictureUrl = coverPictureUrl;
    }
    if (price != null) {
      this._price = price;
    }
    if (stock != null) {
      this._stock = stock;
    }
    if (weight != null) {
      this._weight = weight;
    }
    if (color != null) {
      this._color = color;
    }
    if (discountPercentage != null) {
      this._discountPercentage = discountPercentage;
    }
    if (categories != null) {
      this._categories = categories;
    }
    if (pictures != null) {
      this._pictures = pictures;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get sellerId => _sellerId;
  set sellerId(String? sellerId) => _sellerId = sellerId;
  String? get productCode => _productCode;
  set productCode(String? productCode) => _productCode = productCode;
  String? get name => _name;
  set name(String? name) => _name = name;
  String? get description => _description;
  set description(String? description) => _description = description;
  String? get nameArabic => _nameArabic;
  set nameArabic(String? nameArabic) => _nameArabic = nameArabic;
  String? get descriptionArabic => _descriptionArabic;
  set descriptionArabic(String? descriptionArabic) =>
      _descriptionArabic = descriptionArabic;
  String? get coverPictureUrl => _coverPictureUrl;
  set coverPictureUrl(String? coverPictureUrl) =>
      _coverPictureUrl = coverPictureUrl;
  int? get price => _price;
  set price(int? price) => _price = price;
  int? get stock => _stock;
  set stock(int? stock) => _stock = stock;
  int? get weight => _weight;
  set weight(int? weight) => _weight = weight;
  String? get color => _color;
  set color(String? color) => _color = color;
  int? get discountPercentage => _discountPercentage;
  set discountPercentage(int? discountPercentage) =>
      _discountPercentage = discountPercentage;
  List<Categories>? get categories => _categories;
  set categories(List<Categories>? categories) => _categories = categories;
  List<Pictures>? get pictures => _pictures;
  set pictures(List<Pictures>? pictures) => _pictures = pictures;

  Product.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _sellerId = json['sellerId'];
    _productCode = json['productCode'];
    _name = json['name'];
    _description = json['description'];
    _nameArabic = json['nameArabic'];
    _descriptionArabic = json['descriptionArabic'];
    _coverPictureUrl = json['coverPictureUrl'];
    _price = json['price'];
    _stock = json['stock'];
    _weight = json['weight'];
    _color = json['color'];
    _discountPercentage = json['discountPercentage'];
    if (json['categories'] != null) {
      _categories = <Categories>[];
      json['categories'].forEach((v) {
        _categories!.add(new Categories.fromJson(v));
      });
    }
    if (json['pictures'] != null) {
      _pictures = <Pictures>[];
      json['pictures'].forEach((v) {
        _pictures!.add(new Pictures.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['sellerId'] = this._sellerId;
    data['productCode'] = this._productCode;
    data['name'] = this._name;
    data['description'] = this._description;
    data['nameArabic'] = this._nameArabic;
    data['descriptionArabic'] = this._descriptionArabic;
    data['coverPictureUrl'] = this._coverPictureUrl;
    data['price'] = this._price;
    data['stock'] = this._stock;
    data['weight'] = this._weight;
    data['color'] = this._color;
    data['discountPercentage'] = this._discountPercentage;
    if (this._categories != null) {
      data['categories'] = this._categories!.map((v) => v.toJson()).toList();
    }
    if (this._pictures != null) {
      data['pictures'] = this._pictures!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? _id;
  String? _name;

  Categories({String? id, String? name}) {
    if (id != null) {
      this._id = id;
    }
    if (name != null) {
      this._name = name;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get name => _name;
  set name(String? name) => _name = name;

  Categories.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['name'] = this._name;
    return data;
  }
}

class Pictures {
  String? _id;
  String? _pictureUrl;

  Pictures({String? id, String? pictureUrl}) {
    if (id != null) {
      this._id = id;
    }
    if (pictureUrl != null) {
      this._pictureUrl = pictureUrl;
    }
  }

  String? get id => _id;
  set id(String? id) => _id = id;
  String? get pictureUrl => _pictureUrl;
  set pictureUrl(String? pictureUrl) => _pictureUrl = pictureUrl;

  Pictures.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _pictureUrl = json['pictureUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['pictureUrl'] = this._pictureUrl;
    return data;
  }
}