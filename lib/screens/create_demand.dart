import 'package:flutter/material.dart';
import 'package:flutter_exam/api/food_api.dart';
import 'package:flutter_exam/model/demand.dart';
import 'package:flutter_exam/notifier/auth_notifier.dart';
import 'package:flutter_exam/notifier/demand_notifier.dart';
import 'package:flutter_exam/notifier/housing_notifier.dart';
import 'package:flutter_exam/screens/create_offer.dart';
import 'package:provider/provider.dart';
import 'package:flutter_exam/widgets/menu_drawer.dart';

class CreateDemand extends StatefulWidget {
  @override
  _CreateDemandState createState() => _CreateDemandState();
}

class _CreateDemandState extends State<CreateDemand> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Demand _currentDemand = new Demand();

  @override
  void initState() {
    DemandNotifier housingNotifier =
        Provider.of<DemandNotifier>(context, listen: false);

    if (housingNotifier.currentDemand != null) {
      _currentDemand = housingNotifier.currentDemand;
    } else {
      _currentDemand = Demand();
    }
  }

  Widget _BuildFullNameField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'full name'),
      initialValue: _currentDemand.fullname,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return 'FullName is required';
        }

        if (value.length < 3 || value.length > 20) {
          return 'FullName must be more than 3 and less than 20';
        }

        return null;
      },
      onSaved: (String value) {
        _currentDemand.fullname = value;
      },
    );
  }

  Widget _BuildPhoneField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'phone'),
      initialValue: _currentDemand.phone,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Phone is required';
        }

        if (value.length < 3 || value.length > 20) {
          return 'Phone must be more than 3 and less than 20';
        }

        return null;
      },
      onSaved: (String value) {
        _currentDemand.phone = value;
      },
    );
  }

  Widget _BuildBudgetField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'budget'),
      initialValue: _currentDemand.budget,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return 'budget is required';
        }

        if (value.length < 3 || value.length > 20) {
          return 'budget must be more than 3 and less than 20';
        }

        return null;
      },
      onSaved: (String value) {
        _currentDemand.budget = value;
      },
    );
  }

  Widget _BuildCommentField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'comment'),
      initialValue: _currentDemand.comment,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return 'comment is required';
        }

        if (value.length < 20) {
          return 'comment must be more than 20';
        }

        return null;
      },
      onSaved: (String value) {
        _currentDemand.comment = value;
      },
    );
  }

  _saveDemand() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    uploadDemand(_currentDemand);

    print("Title : ${_currentDemand.fullname}");
    print("Address : ${_currentDemand.phone}");
    print("Capacity: ${_currentDemand.budget}");
    print("Price: ${_currentDemand.comment}");
  }

  @override
  Widget build(BuildContext context) {
    DemandNotifier demandNotifier = Provider.of<DemandNotifier>(context);
    HousingNotifier housingNotifier = Provider.of<HousingNotifier>(context);
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

    Future<void> _refreshList() async {
      getDemands(demandNotifier);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Create demand'),
      ),
      drawer: MenuDrawerHousing(
          housingNotifier: housingNotifier,
          demandNotifier: demandNotifier,
          authNotifier: authNotifier),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(32),
        child: Form(
          key: _formKey,
          autovalidate: true,
          child: Column(
            children: <Widget>[
              Text(
                "Create a Demand",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.0),
              ),
              SizedBox(
                height: 16.0,
              ),
              SizedBox(
                height: 0,
              ),
              _BuildFullNameField(),
              _BuildBudgetField(),
              _BuildPhoneField(),
              _BuildCommentField(),
              SizedBox(
                height: 16.0,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _saveDemand();

          // housingNotifier.addHousing(_currentHousing);

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => Feed()),
          // );
          _currentDemand = null;
          _formKey.currentState.reset();
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.white,
      ),
    );
  }
}
