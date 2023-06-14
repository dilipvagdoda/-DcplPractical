import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical/tab/home_controller.dart';
import 'package:practical/tab/widget/user_details_binding.dart';
import 'package:practical/tab/widget/user_details_view.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User List'),
      ),
      body:  Column(
        children: [
          _buildSearchView(),
          Expanded(child: _buildMainBodyView()),
        ],
      ),
    );
  }
  _buildSearchView(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller.searchController,
        onChanged: (value) {
          controller.searchUsers(value);
        },
        decoration: const InputDecoration(
          hintText: 'Search',
        ),
      ),
    );
  }
  _buildMainBodyView() {
    return Obx(() {
      if (controller.isLoading.value && controller.users.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      } else {
        return ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: controller.filteredUsers.length + 1, // Add +1 for the spinner
          itemBuilder: (context, index) {
            if (index < controller.filteredUsers.length) {
              final user = controller.filteredUsers[index];
              final isFourthAvatar = (index + 1) % 4 == 0;
              return ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.avatarUrl),
                  backgroundColor: isFourthAvatar ? Colors.white : null,
                ),
                title: Text(user.username),
                trailing: user.note.isNotEmpty ? Icon(Icons.note) : null,
                onTap: () {
                  Get.to(const UserDetailsView(),
                      binding: UserDetailsBinding(),
                      arguments: controller.filteredUsers[index]);
                },
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      }
    });
  }

}
