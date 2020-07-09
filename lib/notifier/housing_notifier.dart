import 'dart:collection';

import 'package:flutter/cupertino.dart';
import '../model/housing.dart';

class HousingNotifier with ChangeNotifier {
  List<Housing> _housingList = [];
  Housing _currentHousing;

  UnmodifiableListView<Housing> get housingList =>
      UnmodifiableListView(_housingList);

  Housing get currentHousing => _currentHousing;

  set housingList(List<Housing> housingList) {
    _housingList = housingList;
    notifyListeners();
  }

  set currentHousing(Housing housing) {
    _currentHousing = housing;
    notifyListeners();
  }

  addHousing(Housing housing) {
    _housingList.insert(0, housing);
    notifyListeners();
  }

  deleteHousing(Housing housing) {
    _housingList.removeWhere((_housing) => _housing.id == housing.id);
    notifyListeners();
  }
}
