import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../api_service/api.dart';

class LoginScreen extends StatelessWidget {
  final controller = Get.put(LoginController(), permanent: true);
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
        title: Text(
          'Login Screen',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 20,
              letterSpacing: 2),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              cursorColor: Colors.black,
              controller: usernameController,
              decoration: InputDecoration(
                  labelText: 'Username',
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder()),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              cursorColor: Colors.black,
              controller: passwordController,
              decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.black),
                  enabledBorder: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder()),
              obscureText: true,
            ),
            SizedBox(height: 40),
            Obx(() => controller.isLoading.value
                ? CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    color: Colors.black,
                  )
                : CupertinoButton(
                    color: Colors.blue,
                    onPressed: () => controller.login(
                      usernameController.text,
                      passwordController.text,
                    ),
                    child: Text(
                      'Login',
                      style: TextStyle(letterSpacing: 2),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
