// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Product {
  final String name;
  final double price;
  final String description;
  final String imagePath;
  int quantity;
  int id;

  Product({
    required this.name,
    required this.price,
    required this.description,
    required this.imagePath,
    this.quantity = 1,
    required this.id,
  });

  Product copyWith({
    String? name,
    double? price,
    String? description,
    String? imagePath,
    int? quantity,
    int? id,
  }) {
    return Product(
      name: name ?? this.name,
      price: price ?? this.price,
      description: description ?? this.description,
      imagePath: imagePath ?? this.imagePath,
      quantity: quantity ?? this.quantity,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'price': price,
      'description': description,
      'imagePath': imagePath,
      'quantity': quantity,
      'id': id,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      name: map['name'] as String,
      price: map['price'] as double,
      description: map['description'] as String,
      imagePath: map['imagePath'] as String,
      quantity: map['quantity'] as int,
      id: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) => Product.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Product(name: $name, price: $price, description: $description, imagePath: $imagePath, quantity: $quantity, id: $id)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.price == price &&
      other.description == description &&
      other.imagePath == imagePath &&
      other.quantity == quantity &&
      other.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      price.hashCode ^
      description.hashCode ^
      imagePath.hashCode ^
      quantity.hashCode ^
      id.hashCode;
  }
}
