import 'dart:convert';

import 'package:easyfy_care_patient/features/otp_screen/data/models/verify_otp_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../config.dart';

class SharedPref {
  SharedPreferences? sharedPref;

  Future<SharedPreferences> get _instance async =>
      sharedPref ??= await SharedPreferences.getInstance();

  Future<SharedPreferences> init() async {
    sharedPref = await _instance;
    return sharedPref!;
  }

  Future<bool> save({required String key, required dynamic value}) async {
    debugPrint("........saving");
    if (sharedPref == null) await init();
    switch (value.runtimeType) {
      case const (String):
        return await sharedPref!.setString(key, value);
      case const (bool):
        return await sharedPref!.setBool(key, value);
      case const (int):
        return await sharedPref!.setInt(key, value);
      case const (double):
        return await sharedPref!.setDouble(key, value);
      default:
        return await sharedPref!.setString(key, jsonEncode(value));
    }
  }

  Future<PatientDetailsModel?> getUserData() async {
    if (sharedPref == null) await init();
    final String? patientDetailsJson = sharedPref?.getString("patientDetails");
    if (patientDetailsJson != null) {
      patientDetails =
          PatientDetailsModel.fromJson(jsonDecode(patientDetailsJson));
      return patientDetails;
    }
    patientDetails = null;
    return null;
  }


void clearPatientData() {
  patientDetails = null;
}
  Future<void> clearLoginResponse() async {
    if (sharedPref == null) await init();
    await sharedPref!.remove("patientDetails");
  }
}
