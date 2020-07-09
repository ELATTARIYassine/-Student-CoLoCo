import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter_exam/model/demand.dart';

class DemandNotifier with ChangeNotifier {
  List<Demand> _demandList = [];
  Demand _currentDemand;

  UnmodifiableListView<Demand> get demandList =>
      UnmodifiableListView(_demandList);

  Demand get currentDemand => _currentDemand;

  set demandList(List<Demand> demandList) {
    _demandList = demandList;
    notifyListeners();
  }

  set currentDemand(Demand demand) {
    _currentDemand = demand;
    notifyListeners();
  }

  addDemand(Demand demand) {
    _demandList.insert(0, demand);
    notifyListeners();
  }
}
