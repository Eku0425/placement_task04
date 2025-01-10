import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../sever_scrren/sever.dart';

class LogoutUser extends StatelessWidget {
  const LogoutUser({super.key});

  Future<List<Map<String, dynamic>>> getUserDetails() async {
    final userDetails = await StorageHelper.getUserDetails();
    return userDetails != null
        ? List<Map<String, dynamic>>.from(userDetails)
        : [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: Icon(
              Icons.arrow_back_sharp,
              color: Colors.white,
            )),
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text(
          'All Logout User',
          style: TextStyle(color: Colors.white),
        ),
        // actions: [
        //   PopupMenuItem(child: TextButton(onPressed: () {
        //     Get.toNamed('/home');
        //   }, child: Text('Show All Privous LogOut')))
        // ],
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getUserDetails(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('No LogOut users found'));
          }

          final users = snapshot.data ?? [];
          if (users.length == 1) {
            return Center(child: Text('No LogOut users found'));
          }

          return ListView.builder(
            itemCount: users.length - 1,
            itemBuilder: (context, index) {
              // index = users.length - 2;
              final user = users[index];
              return ListTile(
                  title: Text(user['firstName'] ?? 'No Name'),
                  subtitle: Text(user['email'] ?? 'No Email'),
                  onTap: () {
                    Get.toNamed('/details', arguments: user);
                  });
            },
          );
        },
      ),
    );
  }
}
