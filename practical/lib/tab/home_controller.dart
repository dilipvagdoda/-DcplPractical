import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:practical/helper/database_helper.dart';
import 'package:practical/helper/network_helper.dart';
import 'package:practical/model/user_model.dart';

class HomeController extends GetxController{
  final NetworkHelper networkHelper = NetworkHelper();
  final DatabaseHelper databaseHelper = DatabaseHelper();
  final RxList<User> filteredUsers = <User>[].obs;
  final RxList<User> users = <User>[].obs;
  var isLoading = false.obs;
  final ScrollController _scrollController = ScrollController();
  late Connectivity _connectivity;
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
   TextEditingController searchController = TextEditingController();
  var isOffline = false.obs;
  var since = 0;


  Future<void> fetchUsersFromDatabase() async {
    isLoading.value = true;
    users.value = await databaseHelper.getUsers();
    isLoading.value = false;
  }

  Future<void> fetchUsersFromApi() async {
      isLoading.value = true;
    try {
      final List<User> apiUsers = await networkHelper.fetchUsers(since: since);
      users.addAll(apiUsers);
      since++;
      isLoading.value = false;
      await saveUsersToDatabase(apiUsers);
    } catch (e) {
      print("catch Error --> $e");
      isLoading.value = false;
    }
  }

  Future<void> saveUsersToDatabase(List<User> users) async {
    for (final user in users) {
      await databaseHelper.saveUser(user);
    }
  }
  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent && !_scrollController.position.outOfRange) {
      fetchUsersFromApi();
    }
  }

  Future<void> checkConnectivity({required ConnectivityResult connectivityResult}) async {
    if (connectivityResult == ConnectivityResult.wifi ||connectivityResult == ConnectivityResult.mobile) {
      fetchUsersFromApi();
      isOffline.value = false;
    } else {
      Get.snackbar('connection', 'no internet connection');
      isOffline.value = true;
    }
  }

  void _updateConnectionStatus(ConnectivityResult result) {
    checkConnectivity(connectivityResult: result);
  }

  void searchUsers(String query) {
    if (query.isEmpty) {
      filteredUsers.value = users;
    } else {
      filteredUsers.value = users
          .where((user) => user.username.toLowerCase().contains(query.toLowerCase()) || user.note.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }

  @override
  void onInit() {
    // fetchUsersFromDatabase();
   //  fetchUsersFromApi();
    _connectivity = Connectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _scrollController.addListener(_scrollListener);
    searchUsers('');
    super.onInit();
  }
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }
}