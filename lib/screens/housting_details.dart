import 'package:flutter/material.dart';
import 'package:flutter_exam/notifier/housing_notifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter_exam/widgets/rating_stars.dart';

class HoustingDetails extends StatefulWidget {
  @override
  _HoustingDetailsState createState() => _HoustingDetailsState();
}

class _HoustingDetailsState extends State<HoustingDetails> {
  @override
  Widget build(BuildContext context) {
    HousingNotifier housingNotifier = Provider.of<HousingNotifier>(context);
    bool isFavorite = true;
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Hero(
                tag: housingNotifier.currentHousing.image,
                child: Image(
                  height: 250.0,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                  image: NetworkImage(housingNotifier.currentHousing.image),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: () => Navigator.pop(context),
                      iconSize: 30.0,
                      color: Colors.white,
                    ),
                    IconButton(
                      icon: Icon(Icons.favorite),
                      onPressed: () {
                        setState(() {
                          isFavorite = false;
                        });
                      },
                      color: isFavorite ? Colors.red : Colors.white,
                      iconSize: 35.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      housingNotifier.currentHousing.title,
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      housingNotifier.currentHousing.price + " MAD",
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                RatingStarts(int.parse(housingNotifier.currentHousing.rating)),
                SizedBox(
                  height: 6.0,
                ),
                Text(
                  housingNotifier.currentHousing.address,
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Price :" + housingNotifier.currentHousing.price + "MAD",
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      "Capacity :" + housingNotifier.currentHousing.capacity,
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "Superficie :" +
                      housingNotifier.currentHousing.superficie +
                      " m³",
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  "Phone :" + housingNotifier.currentHousing.phone,
                  style: TextStyle(fontSize: 18.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
