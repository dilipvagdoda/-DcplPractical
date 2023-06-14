import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:practical/helper/database_helper.dart';
import 'package:practical/helper/network_helper.dart';
import 'package:practical/model/user_details_model.dart';
import 'package:practical/model/user_model.dart';

class UserDetailsController extends GetxController{

  final DatabaseHelper databaseHelper = DatabaseHelper();
  final NetworkHelper networkHelper = NetworkHelper();
  User argument = Get.arguments;
  late Rx<UserDetails?> userDetails = Rx<UserDetails?>(null);
  TextEditingController noteController = TextEditingController();


  Future<void> fetchUserProfile() async {
    try {
      final fetchedUser = await networkHelper.fetchUserProfile(argument.username);
      if(argument.note != null){
        noteController = TextEditingController(text: argument.note);
      }
      userDetails.value = fetchedUser;
    } catch (e) {
      printError(info: "error$e");
    }
  }

  Future<void> saveNote() async {
    argument.note = noteController.text;
    await databaseHelper.updateNoteForUser(argument);
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

}