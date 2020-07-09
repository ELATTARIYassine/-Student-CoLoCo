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
    id = data['id'];
    title = data['title'];
    address = data['address'];
    price = data['price'];
    capacity = data['capacity'];
    superficie = data['superficie'];
    image = data['image'];
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
