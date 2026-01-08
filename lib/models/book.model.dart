class Book {
  final String id;
  final String name;
  final String address;
  final DateTime createdAt;
  final String pictureUrl;

  Book({
    required this.id,
    required this.name,
    required this.address,
    required this.createdAt,
    required this.pictureUrl,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as String,
      name: json['name'] as String,
      address: json['address'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      pictureUrl: json['pictureUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address,
      'createdAt': createdAt.toIso8601String(),
      'pictureUrl': pictureUrl,
    };
  }
}
