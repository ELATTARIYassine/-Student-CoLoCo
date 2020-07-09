import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_exam/model/housing.dart';
import 'package:flutter_exam/model/user.dart';
import 'package:flutter_exam/model/demand.dart';
import 'package:flutter_exam/notifier/auth_notifier.dart';
import 'package:flutter_exam/notifier/housing_notifier.dart';
import 'package:flutter_exam/notifier/demand_notifier.dart';
import 'package:path/path.dart' as path;
import 'package:uuid/uuid.dart';

login(User user, AuthNotifier authNotifier) async {
  AuthResult authResult = await FirebaseAuth.instance
      .signInWithEmailAndPassword(email: user.email, password: user.password)
      .catchError((error) => print(error.code));

  if (authResult != null) {
    FirebaseUser firebaseUser = authResult.user;

    if (firebaseUser != null) {
      print("Log In: $firebaseUser");
      authNotifier.setUser(firebaseUser);
    }
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
  QuerySnapshot snapshot =
      await Firestore.instance.collection('Housings').getDocuments();

  List<Housing> _housingList = [];

  snapshot.documents.forEach((document) {
    Housing housing = Housing.fromMap(document.data);
    _housingList.add(housing);
  });

  housingNotifier.housingList = _housingList;
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
  QuerySnapshot snapshot =
      await Firestore.instance.collection('demands').getDocuments();

  List<Demand> _demandList = [];

  snapshot.documents.forEach((document) {
    Demand demand = Demand.fromMap(document.data);
    _demandList.add(demand);
  });

  demandNotifier.demandList = _demandList;
}

uploadDemand(Demand demand) async {
  CollectionReference housingRef = Firestore.instance.collection('demands');

  DocumentReference documentRef = await housingRef.add(demand.toMap());

  demand.id = documentRef.documentID;

  print('uploaded housing successfully: ${demand.toString()}');

  await documentRef.setData(demand.toMap(), merge: true);
}