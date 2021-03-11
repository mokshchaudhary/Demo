import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weight/View/home/homepage.dart';

class AddRecord extends StatefulWidget {
  const AddRecord({Key key}) : super(key: key);

  @override
  _AddRecordState createState() => _AddRecordState();
}

class _AddRecordState extends State<AddRecord> {
  String weight;
  String date;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          'Add Record',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.05),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (_) {
                      setState(() {
                        weight = _;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Weight',
                      border: InputBorder.none,
                      suffixText: 'kg',
                      suffixStyle: TextStyle(fontSize: 45, fontWeight: FontWeight.w100),
                    ),
                    style: TextStyle(fontSize: 60),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.1),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(width: 2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: CupertinoDatePicker(
                    onDateTimeChanged: (_) {
                      print('${_.day}/${_.month}/${_.year}');
                      date = '${_.day}/${_.month}/${_.year}';
                    },
                    mode: CupertinoDatePickerMode.date,
                  ),
                ),
              ),
              Spacer(),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    if (date != null && weight != null && weight.length > 0) {
                      savedata(weight, date);
                      Get.back();
                    } else {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return AlertDialog(
                              title: Text('Please set the data'),
                            );
                          });
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 2),
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void savedata(String weight, String date) async {
  FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser.uid)
      .add({'weight': weight, 'createdon': date});
}
