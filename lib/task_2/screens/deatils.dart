import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../sever_scrren/sever.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final AuthService _authService = AuthService();
  late Future<List<Map<String, dynamic>>> users;
  final user = Get.arguments;

  @override
  void initState() {
    super.initState();
    users = _authService.getAllUsers(); // Call the API to get all users
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
          'User Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: users,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: Colors.black,
            ));
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No users found.'));
          } else {
            final usersList = snapshot.data!;
            int dataIndex = 0;
            for (int i = 0; i < usersList.length; i++) {
              if (user['firstName'] == usersList[i]['firstName']) {
                dataIndex = i;
              }
            }
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUserImage(usersList[dataIndex]['image']),
                  _buildSectionTitle("Basic Information"),
                  _buildUserInfo("Username", usersList[dataIndex]['username']),
                  _buildUserInfo("Email", usersList[dataIndex]['email']),
                  _buildUserInfo("Phone", usersList[dataIndex]['phone']),
                  _buildUserInfo("Gender", usersList[dataIndex]['gender']),
                  _buildUserInfo("Age", usersList[dataIndex]['age'].toString()),
                  _buildUserInfo(
                      "Birth Date", usersList[dataIndex]['birthDate']),
                  _buildUserInfo("Role", usersList[dataIndex]['role']),
                  _buildSectionTitle("Appearance"),
                  _buildUserInfo(
                      "Height", "${usersList[dataIndex]['height']} cm"),
                  _buildUserInfo(
                      "Weight", "${usersList[dataIndex]['weight']} kg"),
                  _buildUserInfo("Eye Color", usersList[dataIndex]['eyeColor']),
                  _buildUserInfo(
                      "Hair Color", usersList[dataIndex]['hair']['color']),
                  _buildUserInfo(
                      "Hair Type", usersList[dataIndex]['hair']['type']),
                  _buildSectionTitle("Address"),
                  _buildUserInfo(
                      "Address",
                      "${usersList[dataIndex]['address']['address']}, ${usersList[dataIndex]['address']['city']}, ${usersList[dataIndex]['address']['state']} "
                          "(${usersList[dataIndex]['address']['postalCode']}), ${usersList[dataIndex]['address']['country']}"),
                  _buildUserInfo("Coordinates",
                      "Lat: ${usersList[dataIndex]['address']['coordinates']['lat']}, Lng: ${usersList[dataIndex]['address']['coordinates']['lng']}"),
                  _buildSectionTitle("Company"),
                  _buildUserInfo(
                      "Company Name", usersList[dataIndex]['company']['name']),
                  _buildUserInfo("Department",
                      usersList[dataIndex]['company']['department']),
                  _buildUserInfo(
                      "Title", usersList[dataIndex]['company']['title']),
                  _buildUserInfo(
                      "Company Address",
                      "${usersList[dataIndex]['company']['address']['address']}, ${usersList[dataIndex]['company']['address']['city']}, "
                          "${usersList[dataIndex]['company']['address']['state']} (${usersList[dataIndex]['company']['address']['postalCode']})"),
                  _buildSectionTitle("Bank Details"),
                  _buildUserInfo(
                      "Card Type", usersList[dataIndex]['bank']['cardType']),
                  _buildUserInfo("Card Number",
                      usersList[dataIndex]['bank']['cardNumber']),
                  _buildUserInfo("Card Expiry",
                      usersList[dataIndex]['bank']['cardExpire']),
                  _buildUserInfo("IBAN", usersList[dataIndex]['bank']['iban']),
                  _buildSectionTitle("Crypto"),
                  _buildUserInfo(
                      "Coin", usersList[dataIndex]['crypto']['coin']),
                  _buildUserInfo(
                      "Wallet", usersList[dataIndex]['crypto']['wallet']),
                  _buildUserInfo(
                      "Network", usersList[dataIndex]['crypto']['network']),
                  _buildSectionTitle("Other Details"),
                  _buildUserInfo("IP", usersList[dataIndex]['ip']),
                  _buildUserInfo(
                      "Mac Address", usersList[dataIndex]['macAddress']),
                  _buildUserInfo(
                      "University", usersList[dataIndex]['university']),
                  _buildUserInfo("EIN", usersList[dataIndex]['ein']),
                  _buildUserInfo("SSN", usersList[dataIndex]['ssn']),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildUserImage(String imageUrl) {
    return Center(
      child: CircleAvatar(
        radius: 50,
        backgroundImage: NetworkImage(imageUrl),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Text(
        '$title :',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
    );
  }

  Widget _buildUserInfo(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$label: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
