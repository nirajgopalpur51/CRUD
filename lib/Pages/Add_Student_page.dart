// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddStudentPage extends StatefulWidget {
  const AddStudentPage({Key? key}) : super(key: key);

  @override
  State<AddStudentPage> createState() => _AddStudentPageState();
}

class _AddStudentPageState extends State<AddStudentPage> {
  final _formakey=GlobalKey<FormState>();

  var name="";
  var email="";
  var password="";

  final nameController=TextEditingController();
  final emailController=TextEditingController();
  final passwordController =TextEditingController();

  void dispose(){
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  clearText(){
    nameController.clear();
    emailController.clear();
    passwordController.clear();
  }

  // Adding data
  CollectionReference students=FirebaseFirestore.instance
      .collection("students");

  Future<void>addUser(){
    return students
        .add({'name':name,"email":email,"password":password})
    .then((value) => print("user Added")).
    catchError((error)=>print("Failed to Add user : $error"));
    // print("User added");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add new student"),
      ),
      body: Form(
        key: _formakey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal:20,vertical: 30 ),
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 10
                ),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(
                      fontSize: 20
                    ),
                    border: OutlineInputBorder(),
                    errorStyle: TextStyle(
                      color: Colors.redAccent,fontSize: 15
                    )
                  ),
                  controller: nameController,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10
                ),
                child: TextFormField(
                  autofocus: false,
                  decoration: InputDecoration(
                      labelText: "Email",
                      labelStyle: TextStyle(
                          fontSize: 20
                      ),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(
                          color: Colors.redAccent,fontSize: 15
                      )
                  ),
                  controller: emailController,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please Enter email';
                    }
                    else if(!value.contains("@")){
                      return "Please Enter valid email";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10
                ),
                child: TextFormField(
                  obscureText: true,
                  autofocus: false,
                  decoration: InputDecoration(
                      labelText: "Password",
                      labelStyle: TextStyle(
                          fontSize: 20
                      ),
                      border: OutlineInputBorder(),
                      errorStyle: TextStyle(
                          color: Colors.redAccent,fontSize: 15
                      )
                  ),
                  controller: passwordController,
                  validator: (value){
                    if(value==null || value.isEmpty){
                      return 'Please Enter password';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        onPressed: (){
                          if(_formakey.currentState!.validate()){
                            setState(() {
                              name=nameController.text.toString();
                              email=emailController.text.toString();
                              password=passwordController.text.toString();
                              addUser();
                              clearText();  //after register clear the textfield
                            });
                          }
                        },
                        child: Text(
                          "Register",
                          style: TextStyle(fontSize: 18),
                        )),
                    ElevatedButton(
                        onPressed: (){
                          clearText();
                        },
                        child: Text("Reset",style: TextStyle(fontSize: 18),),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey
                    ),)
                  ],
                ),
              )
            ],
          ),
        ),
      ),

    );
  }
}
