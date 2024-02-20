class Fungicide {
  final String name;
  final String price;
  final String disease;
  final String image;

  Fungicide({
    required this.name,
    required this.price,
    required this.disease,
    required this.image,
  });

  factory Fungicide.fromJson(Map<String, dynamic> json, String disease) {
    return Fungicide(
      name: json['name'],
      price: json['price'],
      disease: disease,
      image: json['image'],
    );
  }
}
