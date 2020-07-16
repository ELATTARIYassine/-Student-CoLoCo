class Housing {
  String id;
  String title;
  String address;
  String price;
  String capacity;
  String superficie;
  String image;
  String rating;
  String latitude;
  String longitude;
  String phone;
  // Housing({title: 'erer'});
  Housing();

  Housing.fromMap(Map<String, dynamic> data) {
    id = data['id'].toString();
    title = data['title'];
    address = data['address'];
    price = data['price'].toString();
    capacity = data['capacity'].toString();
    superficie = data['superficie'].toString();
    image = data['images'];
    rating = data['rating'];
    latitude = data['latitude'];
    longitude = data['longitude'];
    phone = data['phone'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'address': address,
      'price': price,
      'capacity': capacity,
      'superficie': superficie,
      'image': image,
      'rating': rating,
      'latitude': latitude,
      'longitude': longitude,
      'phone': phone,
    };
  }
}
