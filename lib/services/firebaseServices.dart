import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:apptracker/model/appInfoModel.dart';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';

const collection = "devappinfocloudfirestore";
const storageFolderName = "devappIcon";

//TODO: gets the list of all app information from cloud
class FirebaseServices {
  static Stream<List<AppInfoModel>> getAllAppsInfo() {
    final connection = FirebaseFirestore.instance.collection(collection);
    return connection.orderBy("appname").snapshots().map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => AppInfoModel.fromJson(
                  doc.data(),
                ),
              )
              .toList(),
        );
  }

  //TODO:update the app info
  static Future<bool> updateAppInfo({
    required AppInfoModel instance,
    required String docId,
    File? image,
  }) async {
    try {
      if (image != null) {
        var link = await _updateImageFromFirebaseStorage(
            instance.imageUrl.toString(), image);
        instance.imageUrl = link;
      }
      var connection = FirebaseFirestore.instance.collection(collection);
      await connection
          .doc(docId) // <-- Doc ID where data should be updated.
          .update(instance.toJson());
      return true;
    } catch (e) {
      // TODO Log error here
      developer.log(e.toString());
      return false;
    }
  }

  //TODO: delete the app info
  static bool deleteAppInfo({required String docID, required String url}) {
    try {
      _deleteImageFromFirebaseStorage(url);
      var connection = FirebaseFirestore.instance.collection(collection);
      connection
          .doc(docID) // <-- Doc ID to be deleted.
          .delete();

      return true;
    } catch (e) {
      return false;
    }
  }

  //TODO: create the app info
  static Future<bool> createAppInfo({required AppInfoModel instance}) async {
    try {
      var connection = FirebaseFirestore.instance.collection(collection);
      await connection.add(instance.toJson());
      return true;
    } catch (e) {
      return false;
    }
  }

  //TODO: upload image to the storage and get the link
  static Future<String> uploadImageToFirebaseStorage(
      {required File image}) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    try {
      Reference references = storage
          .refFromURL('gs://apptracker-576af.appspot.com')
          .child(storageFolderName);
      final TaskSnapshot snapshot = await references
          .child(image.name + DateTime.now().toIso8601String())
          .putBlob(image);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint(e.toString());
      developer.log(e.toString());
      return "error";
    }
  }

  static Future<String> _updateImageFromFirebaseStorage(
      String url, File image) async {
    try {
      final TaskSnapshot snapshot =
          await FirebaseStorage.instance.refFromURL(url).putBlob(image);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint(e.toString());
      return "error";
    }
  }

  static Future<bool> _deleteImageFromFirebaseStorage(String url) async {
    try {
      await FirebaseStorage.instance.refFromURL(url).delete();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      developer.log(e.toString());
      return false;
    }
  }
}
