import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../layout/nav_layout.dart';
import '../../screens/order_history_screen/api/order_history_api.dart';
import '../../screens/order_history_screen/widgets/order_history_card.dart';

import 'package:flutter/material.dart';

class FranchisePage extends StatefulWidget {
  @override
  _FranchisePageState createState() => _FranchisePageState();
}

class _FranchisePageState extends State<FranchisePage> {
  // Variables to store user input
  String franchiseName = '';
  String contactInfo = '';
  String description = '';
  String requirement = '';
  String investment = '';

  // Form key
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Franchise Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Franchise Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter franchise name';
                  }
                  return null;
                },
                onSaved: (value) {
                  franchiseName = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Contact Info'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter contact info';
                  }
                  return null;
                },
                onSaved: (value) {
                  contactInfo = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
                onSaved: (value) {
                  description = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Requirement'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter requirement';
                  }
                  return null;
                },
                onSaved: (value) {
                  requirement = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Investment'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter investment';
                  }
                  return null;
                },
                onSaved: (value) {
                  investment = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    // Use the values stored in variables (franchiseName, contactInfo, etc.)
                    // for further processing, e.g., sending to a database.
                    // You can also navigate to another screen or perform any other action here.
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Submitted Data'),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('Franchise Name: $franchiseName'),
                              Text('Contact Info: $contactInfo'),
                              Text('Description: $description'),
                              Text('Requirement: $requirement'),
                              Text('Investment: $investment'),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                    createFranchise(franchiseName, contactInfo, requirement, int.parse(investment), description);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future<Franchise> createFranchise(String franchiseName, String contactInfo, String requirements, int investments, String description) async {
    final http.Response response = await http.post(
      Uri.parse('https://franchises-api.onrender.com/api/Franchise/store'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "Franchise_Name" : franchiseName,
        "Contact_Info": contactInfo,
        "Description": description,
        "Investments": investments,
        "Requierement":requirements
      }),
    );
    if (response.statusCode == 201) {
      return Franchise.fromJson(json.decode(response.body));
    } else {
      throw Exception('Franchise loading failed!');
    }
  }
}
class Franchise {
  final int Investments;
  final String Franchise_Name;
  final String Contact_Info;
  final String Description;
  final String Requierements;

  Franchise({required this.Investments, required this.Contact_Info, required this.Description, required this.Franchise_Name, required this.Requierements});

  factory   Franchise.fromJson(Map<String, dynamic> json) {
    return   Franchise(
        Investments: json["Investments"],
        Franchise_Name: json['Franchise_Name'],
        Contact_Info: json["Contact_Info"],
        Description: json["Description"],
        Requierements: json["Requierements"]
    );
  }
}