import 'package:metaverseplay/model/aboutus_model.dart';
import 'package:metaverseplay/model/termsconditionModel.dart';
import 'package:flutter/material.dart';


class ContactUsProvider with ChangeNotifier {
  TcModel? _contactusData;

  TcModel? get ContactusData => _contactusData;

  void setCu(TcModel contactData) {
    _contactusData = contactData;
    notifyListeners();
  }
}