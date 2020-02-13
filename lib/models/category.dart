class Category {
  //Category();
  int category_id;
  String category_code;
  String category_name;
  String description;
  String category_image;
  //List<Category> category = new List<Category>();

  Category(
      //{this.category_id, this.category_code, this.category_name, this.description, this.category_image, List<Category> child});
          {this.category_id, this.category_code, this.category_name, this.description, this.category_image});

  factory Category.fromJson(Map<dynamic, dynamic> json) {
    return Category(
        category_id: json['category_id'] as int,
        category_code: json['category_code'] as String,
        category_name: json['category_name'] as String,
        description: json['description'] as String,
        category_image: json['category_image'] as String,
        //child: json['child'] as List<Category>,
    );
  }
}

