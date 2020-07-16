import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_exam/api/constant.dart';
import 'package:flutter_exam/model/housing.dart';
import 'package:flutter_exam/model/user.dart';
import 'package:flutter_exam/model/demand.dart';
import 'package:flutter_exam/notifier/auth_notifier.dart';
import 'package:flutter_exam/notifier/housing_notifier.dart';
import 'package:flutter_exam/notifier/demand_notifier.dart';
import 'package:http/http.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

login(User user, AuthNotifier authNotifier) async {
  Response res = await get(constants.api + "api/housings-offers");

  if (res != null) {
    var firebaseUser;
    User user = res.user;

    if (firebaseUser != null) {
      print("Log In: $user");
      authNotifier.setUser(user);
    }
  }
}

uploadHousingAndImagev2(Housing housing, File localFile) async {
  if (localFile != null) {
    print("uploading image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4();
    housing.image = uuid + fileExtension;
    Response res =
        await post(constants.api + "api/housings-offers/create", body: housing);
  } else {
    print('...skipping image upload');
    //_uploadFood(food, isUpdating, foodUploaded);
  }
}

signup(User user, AuthNotifier authNotifier) async {
  AuthResult authResult = await FirebaseAuth.instance
      .createUserWithEmailAndPassword(
          email: user.email, password: user.password)
      .catchError((error) => print(error.code));

  if (authResult != null) {
    UserUpdateInfo updateInfo = UserUpdateInfo();
    updateInfo.displayName = user.displayName;

    FirebaseUser firebaseUser = authResult.user;

    if (firebaseUser != null) {
      await firebaseUser.updateProfile(updateInfo);

      await firebaseUser.reload();

      print("Sign up: $firebaseUser");

      FirebaseUser currentUser = await FirebaseAuth.instance.currentUser();
      authNotifier.setUser(currentUser);
    }
  }
}

signout(AuthNotifier authNotifier) async {
  await FirebaseAuth.instance
      .signOut()
      .catchError((error) => print(error.code));

  authNotifier.setUser(null);
}

initializeCurrentUser(AuthNotifier authNotifier) async {
  FirebaseUser firebaseUser = await FirebaseAuth.instance.currentUser();

  if (firebaseUser != null) {
    print(firebaseUser);
    authNotifier.setUser(firebaseUser);
  }
}

getHoustings(HousingNotifier housingNotifier) async {
  Response res = await get(constants.api + "api/housings-offers");
  if (res.statusCode == 200) {
    List<dynamic> body = jsonDecode(res.body);

    List<Housing> _housingList = [];

    body.forEach((obj) {
      Housing housing = Housing.fromMap(obj);
      _housingList.add(housing);
    });

    housingNotifier.housingList = _housingList;
  } else {
    throw "Can't get housings.";
  }
}

uploadHousingAndImage(Housing housing, File localFile) async {
  if (localFile != null) {
    print("uploading image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4();

    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('housings/images/$uuid$fileExtension');

    await firebaseStorageRef
        .putFile(localFile)
        .onComplete
        .catchError((onError) {
      print(onError);
      return false;
    });

    String url = await firebaseStorageRef.getDownloadURL();
    print("download url: $url");
    _uploadHousing(housing, imageUrl: url);
  } else {
    print('...skipping image upload');
    //_uploadFood(food, isUpdating, foodUploaded);
  }
}

_uploadHousing(Housing housing, {String imageUrl}) async {
  CollectionReference housingRef = Firestore.instance.collection('Housings');

  if (imageUrl != null) {
    housing.image = imageUrl;
  }

  DocumentReference documentRef = await housingRef.add(housing.toMap());

  housing.id = documentRef.documentID;

  print('uploaded housing successfully: ${housing.toString()}');

  await documentRef.setData(housing.toMap(), merge: true);
}

getDemands(DemandNotifier demandNotifier) async {
  Response res = await get(constants.api + "api/housings-demands");
  if (res.statusCode == 200) {
    List<dynamic> body = jsonDecode(res.body);

    List<Demand> _demandList = [];

    body.forEach((obj) {
      Demand demand = Demand.fromMap(obj);
      _demandList.add(demand);
    });

    demandNotifier.demandList = _demandList;
  } else {
    throw "Can't get demands.";
  }
}

uploadDemand(Demand demand) async {
  CollectionReference housingRef = Firestore.instance.collection('demands');

  DocumentReference documentRef = await housingRef.add(demand.toMap());

  demand.id = documentRef.documentID;

  print('uploaded housing successfully: ${demand.toString()}');

  await documentRef.setData(demand.toMap(), merge: true);
}

uploadHousingAnsdImage(Housing housing, File localFile) async {
  if (localFile != null) {
    print("uploading image");

    var fileExtension = path.extension(localFile.path);
    print(fileExtension);

    var uuid = Uuid().v4();

    final StorageReference firebaseStorageRef = FirebaseStorage.instance
        .ref()
        .child('housings/images/$uuid$fileExtension');

    await firebaseStorageRef
        .putFile(localFile)
        .onComplete
        .catchError((onError) {
      print(onError);
      return false;
    });

    String url = await firebaseStorageRef.getDownloadURL();
    print("download url: $url");
    _uploadHousing(housing, imageUrl: url);
  } else {
    print('...skipping image upload');
    //_uploadFood(food, isUpdating, foodUploaded);
  }
}
