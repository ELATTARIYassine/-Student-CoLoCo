class Demand {
  String id;
  String fullname;
  String phone;
  String budget;
  String comment;

  // Demand({title: 'erer'});
  Demand();

  Demand.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    fullname = data['fullname'];
    phone = data['phone'];
    budget = data['budget'];
    comment = data['comment'];
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullname': fullname,
      'phone': phone,
      'budget': budget,
      'comment': comment
    };
  }
}
