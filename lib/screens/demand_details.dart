import 'package:flutter/material.dart';
import 'package:flutter_exam/notifier/demand_notifier.dart';
import 'package:provider/provider.dart';

class DemandDetails extends StatefulWidget {
  @override
  _DemandDetailsState createState() => _DemandDetailsState();
}

class _DemandDetailsState extends State<DemandDetails> {
  @override
  Widget build(BuildContext context) {
    DemandNotifier demandNotifier = Provider.of<DemandNotifier>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(demandNotifier.currentDemand.fullname + " details"),
      ),
      body: Container(
        margin: EdgeInsets.all(40.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "FullName: ",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(demandNotifier.currentDemand.fullname)
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Budget: ",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(demandNotifier.currentDemand.budget + " MAD")
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Phone: ",
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
                Text(demandNotifier.currentDemand.phone)
              ],
            ),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Preferences',
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              demandNotifier.currentDemand.comment,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
