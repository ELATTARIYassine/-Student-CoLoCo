import 'package:flutter/material.dart';
import 'package:flutter_exam/api/food_api.dart';
import 'package:flutter_exam/notifier/auth_notifier.dart';
import 'package:flutter_exam/notifier/housing_notifier.dart';
import 'package:flutter_exam/notifier/demand_notifier.dart';
import 'package:flutter_exam/screens/create_offer.dart';
import 'package:flutter_exam/screens/create_demand.dart';
import 'package:flutter_exam/screens/demands.dart';
import 'package:flutter_exam/screens/feed.dart';
import 'package:flutter_exam/screens/housing_map.dart';
import 'package:flutter_exam/screens/login.dart';

class MenuDrawerHousing extends StatelessWidget {
  HousingNotifier housingNotifier;
  DemandNotifier demandNotifier;
  AuthNotifier authNotifier;
  MenuDrawerHousing(
      {this.housingNotifier, this.demandNotifier, this.authNotifier});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'Student-CoLoCo',
                style: TextStyle(color: Colors.white, fontSize: 30.0),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Offer list'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Feed()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.assignment),
            title: Text('Demands list'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => demandsFeed()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Create Offer'),
            onTap: () {
              housingNotifier.currentHousing = null;
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateOffer()),
              );
              // Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Create Demand'),
            onTap: () {
              demandNotifier.currentDemand = null;
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CreateDemand()),
              );
              // Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('Map'),
            onTap: () {
              // Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HousingMap()),
              );
              // Navigator.of(context).pop();
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              // Navigator.of(context).pop();
              signout(authNotifier);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },
          ),
        ],
      ),
    );
  }
}
