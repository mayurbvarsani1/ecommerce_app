class Product {
  late final int id;
  final String slug;
  late final String title;
  final String description;
  late final int price;
  late final String featuredImage;
  final String status;
  final String createdAt;

  Product({
    required this.id,
    required this.slug,
    required this.title,
    required this.description,
    required this.price,
    required this.featuredImage,
    required this.status,
    required this.createdAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      slug: json['slug'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      featuredImage: json['featured_image'],
      status: json['status'],
      createdAt: json['created_at'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'slug': slug,
      'title': title,
      'description': description,
      'price': price,
      'featured_image': featuredImage,
      'status': status,
      'created_at': createdAt,
    };
  }
}