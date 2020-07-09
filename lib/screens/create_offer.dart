import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_exam/api/food_api.dart';
import 'package:flutter_exam/model/housing.dart';
import 'package:flutter_exam/notifier/auth_notifier.dart';
import 'package:flutter_exam/notifier/housing_notifier.dart';
import 'package:flutter_exam/notifier/demand_notifier.dart';
import 'package:flutter_exam/screens/create_demand.dart';
import 'package:flutter_exam/screens/feed.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:flutter_exam/widgets/menu_drawer.dart';

class CreateOffer extends StatefulWidget {
  @override
  _CreateOfferState createState() => _CreateOfferState();
}

class _CreateOfferState extends State<CreateOffer> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Housing _currentHousing = new Housing();
  String _imageUrl;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  File _imageFile;

  Widget _showImage() {
    if (_imageFile == null && _imageUrl == null) {
      return Text("Image is here");
    } else if (_imageFile != null) {
      return Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          Image.file(
            _imageFile,
            fit: BoxFit.cover,
            height: 250,
          ),
          FlatButton(
            padding: EdgeInsets.all(16),
            color: Colors.black54,
            child: Text(
              'Change Image',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w400),
            ),
            onPressed: () => _getLocalImage(),
          )
        ],
      );
    } else if (_imageUrl != null) {
      return Text("Image is here");
    }
  }

  _getLocalImage() async {
    File imageFile = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50, maxWidth: 400);
    if (imageFile != null) {
      setState(() {
        _imageFile = imageFile;
      });
    }
  }

  @override
  void initState() {
    HousingNotifier housingNotifier =
        Provider.of<HousingNotifier>(context, listen: false);
    if (housingNotifier.currentHousing != null) {
      _currentHousing = housingNotifier.currentHousing;
    } else {
      _currentHousing = Housing();
    }
  }

  Widget _BuildTitleField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'title'),
      initialValue: _currentHousing.title,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Title is required';
        }

        if (value.length < 3 || value.length > 20) {
          return 'Title must be more than 3 and less than 20';
        }

        return null;
      },
      onSaved: (String value) {
        _currentHousing.title = value;
      },
    );
  }

  Widget _BuildAddressField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Address'),
      initialValue: _currentHousing.address,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Address is required';
        }

        if (value.length < 3 || value.length > 20) {
          return 'Address must be more than 3 and less than 20';
        }

        return null;
      },
      onSaved: (String value) {
        _currentHousing.address = value;
      },
    );
  }

  Widget _BuildPriceField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Price'),
      initialValue: _currentHousing.price,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Price is required';
        }

        return null;
      },
      onSaved: (String value) {
        _currentHousing.price = value;
      },
    );
  }

  Widget _BuildCapacityField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Capacity'),
      initialValue: _currentHousing.capacity,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Capacity is required';
        }

        return null;
      },
      onSaved: (String value) {
        _currentHousing.capacity = value;
      },
    );
  }

  Widget _BuildSuperField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Superficie'),
      initialValue: _currentHousing.superficie,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Superficie is required';
        }

        return null;
      },
      onSaved: (String value) {
        _currentHousing.superficie = value;
      },
    );
  }

  Widget _BuildRatingField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Rating'),
      initialValue: _currentHousing.rating,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Rating is required';
        }
        return null;
      },
      onSaved: (String value) {
        _currentHousing.rating = value;
      },
    );
  }

  Widget _BuildPhoneField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Phone'),
      initialValue: _currentHousing.phone,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return 'phone is required';
        }
        return null;
      },
      onSaved: (String value) {
        _currentHousing.phone = value;
      },
    );
  }

  Widget _BuildLatitudeField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Latitude'),
      initialValue: _currentHousing.latitude,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return 'latitude is required';
        }
        return null;
      },
      onSaved: (String value) {
        _currentHousing.latitude = value;
      },
    );
  }

  Widget _BuildLongitudeField() {
    return TextFormField(
      decoration: InputDecoration(labelText: 'Longitude'),
      initialValue: _currentHousing.latitude,
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return 'longitude is required';
        }
        return null;
      },
      onSaved: (String value) {
        _currentHousing.longitude = value;
      },
    );
  }

  _saveHousing() {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();

    uploadHousingAndImage(_currentHousing, _imageFile);

    print("Title : ${_currentHousing.title}");
    print("Address : ${_currentHousing.address}");
    print("Capacity: ${_currentHousing.capacity}");
    print("Price: ${_currentHousing.price}");
    print("Image: ${_imageFile.toString()}");
    print("Superficie: ${_currentHousing.superficie}");
    print("Rating: ${_currentHousing.rating}");
    print("Image URL: ${_imageUrl}");
  }

  @override
  Widget build(BuildContext context) {
    HousingNotifier housingNotifier = Provider.of<HousingNotifier>(context);
    DemandNotifier demandNotifier = Provider.of<DemandNotifier>(context);
    AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);

    Future<void> _refreshList() async {
      getHoustings(housingNotifier);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('SOMETHING'),
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
              _showImage(),
              SizedBox(
                height: 16.0,
              ),
              Text(
                "Create an Offer",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30.0),
              ),
              SizedBox(
                height: 16.0,
              ),
              _imageFile == null && _imageUrl == null
                  ? ButtonTheme(
                      child: RaisedButton(
                        onPressed: () {
                          _getLocalImage();
                        },
                        child: Text(
                          'Add Image',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: 0,
                    ),
              _BuildTitleField(),
              _BuildAddressField(),
              _BuildPriceField(),
              _BuildCapacityField(),
              _BuildSuperField(),
              _BuildRatingField(),
              _BuildPhoneField(),
              _BuildLatitudeField(),
              _BuildLongitudeField(),
              SizedBox(
                height: 16.0,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _saveHousing();

          _currentHousing.image = _imageUrl;

          // housingNotifier.addHousing(_currentHousing);

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => Feed()),
          // );
          _currentHousing = null;
          _formKey.currentState.reset();
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.white,
      ),
    );
  }
}
