import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:practical/tab/widget/user_details_controller.dart';

class UserDetailsView extends GetView<UserDetailsController> {
  const UserDetailsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Details'),
      ),
      body: _buildMainBody(),
    );
  }
  _buildMainBody(){
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Obx(() {
        return Column(
          children: [
            _buildImageView(),
            _buildFollowersView(),
            _buildDetailsView(),
            _buildNoteView(),
            _buildNoteView(),
          ],
        );
      }),
    );
  }
  _buildImageView(){
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        width: Get.width,
        child:Image.network(controller.userDetails.value?.avatarUrl ?? "", fit: BoxFit.fill),
      ),
    );
    // CircleAvatar(
    //   radius: 80,
    //   backgroundImage: controller.userDetails.value?.avatarUrl != null && controller.userDetails.value!.avatarUrl!.isNotEmpty
    //       ? NetworkImage(controller.userDetails.value?.avatarUrl ?? "") as ImageProvider<Object>
    //       : AssetImage('path_to_placeholder_image'), // Provide a fallback image path
    // ),
  }

  _buildFollowersView(){
    return  Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('followers : ${controller.userDetails.value?.followers ?? 0}',),
        Text('following : ${controller.userDetails.value?.following ?? 0}',),
      ],
    );
  }

  _buildDetailsView(){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('name : ${controller.userDetails.value?.username ?? ""}',),
              const SizedBox(
                height: 6,
              ),
              Text('company : ${controller.userDetails.value?.company ?? ""}',),
              const SizedBox(
                height: 8,
              ),
              Text('blog : ${controller.userDetails.value?.blog ?? ""}',),
            ],
          ),
        ),
      ),
    );
  }
  _buildNoteView(){
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Note:',
            style: TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller.noteController,
            maxLines: 3,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async{
              await controller.saveNote();
              Get.back();
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

