import 'package:flutter/material.dart';
import 'package:flutter_exam/api/food_api.dart';
import 'package:flutter_exam/model/housing.dart';
import 'package:flutter_exam/notifier/housing_notifier.dart';
import 'package:flutter_exam/screens/housting_details.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:provider/provider.dart';

class HousingMap extends StatefulWidget {
  @override
  _HousingMapState createState() => _HousingMapState();
}

class _HousingMapState extends State<HousingMap> {
  @override
  void initState() {
    HousingNotifier housingNotifier =
        Provider.of<HousingNotifier>(context, listen: false);
    getHoustings(housingNotifier);
    super.initState();
  }

  var list = [
    [32.33631476281068, -6.351127624511719],
    [32.33551703575901, -6.358509063720703]
  ];
  _makeMarkers(Housing item, HousingNotifier housingNotifier) {
    return Marker(
        width: 45.0,
        height: 45.0,
        point: new LatLng(
            double.parse(item.latitude), double.parse(item.longitude)),
        builder: (context) => new Container(
              child: IconButton(
                  icon: Icon(Icons.location_on),
                  onPressed: () {
                    print('Marker tapped!');
                    housingNotifier.currentHousing = item;
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => HoustingDetails(),
                      ),
                    );
                  }),
            ));
  }

  @override
  Widget build(BuildContext context) {
    HousingNotifier housingNotifier = Provider.of<HousingNotifier>(context);
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Map Application'),
      ),
      body: Stack(
        children: <Widget>[
          new FlutterMap(
              options: new MapOptions(
                  minZoom: 14.0, center: new LatLng(32.339444, -6.360833)),
              layers: [
                new TileLayerOptions(
                    urlTemplate:
                        'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c']),
                new MarkerLayerOptions(markers: [
                  for (var item in housingNotifier.housingList)
                    _makeMarkers(item, housingNotifier)
                  // Marker(
                  //     width: 45.0,
                  //     height: 45.0,
                  //     point: new LatLng(32.33631476281068, -6.351127624511719),
                  //     builder: (context) => new Container(
                  //           child: IconButton(
                  //               icon: Icon(Icons.location_on),
                  //               onPressed: () {
                  //                 print('Marker tapped!');
                  //               }),
                  //         ))
                ])
              ])
        ],
      ),
    );
  }
}
