class Category {
  final int id;
  final String url;
  final String en;
  final String fr;

  Category({this.id, this.url, this.en, this.fr});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        id: json['id'], url: json['url'], en: json['en'], fr: json['fr']);
  }
}

class CategoryCollection {
  final List<Category> categories;

  CategoryCollection({this.categories});

  factory CategoryCollection.fromJson(json) {
    return CategoryCollection(
      categories: json.map<Category>((json) => Category.fromJson(json as Map<String, dynamic>)).toList(),
    );
  }
}
