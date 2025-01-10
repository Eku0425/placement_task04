import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_service/api.dart';
import '../sever_scrren/sever.dart';

class HomeScreenData extends StatelessWidget {
  const HomeScreenData({super.key});

  Future<List<Map<String, dynamic>>> getUserDetails() async {
    final userDetails = await StorageHelper.getUserDetails();
    return userDetails != null
        ? List<Map<String, dynamic>>.from(userDetails)
        : [];
  }

  @override
  Widget build(BuildContext context) {
    var con = Get.put(LoginController());
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: Text(
            'Home Screen',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                con.loginOrLogOut = false;
                Navigator.pushNamed(context, '/login');
                con.screenViewLogin();
              },
            ),
          ],
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: getUserDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: CircularProgressIndicator(
                backgroundColor: Colors.white,
                color: Colors.black,
              ));
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final users = snapshot.data ?? [];
            if (users.isEmpty) {
              return Center(child: Text('No users found'));
            }

            return Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: ListTile(
                    title:
                        Text(users[users.length - 1]['firstName'] ?? 'No Name'),
                    subtitle:
                        Text(users[users.length - 1]['email'] ?? 'No Email'),
                    onTap: () {
                      Get.toNamed('/details',
                          arguments: users[users.length - 1]);
                    }),
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {},
          child: Center(
            child: IconButton(
              onPressed: () {
                Get.toNamed('/logOutData');
              },
              icon: Icon(
                Icons.remove_red_eye_outlined,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ));
  }
}
