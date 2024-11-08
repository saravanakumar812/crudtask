import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'CustomButtons.dart';

class CustomButtonPage extends StatelessWidget {
  String? Name;
  String? age;

  getUserName(name) {
    this.Name = name;
  }

  getUserAge(age) {
    this.age = age;
  }

  final CollectionReference users =
      FirebaseFirestore.instance.collection('MyUsers');

  Future<void> createUser() async {
    // await users.add({'Name': Name, 'age': age});
    // print("User created!");

    DocumentReference users =
        FirebaseFirestore.instance.collection('MyUsers').doc(Name);

    Map<String, dynamic> students = {"Name": Name, "age": age};

    users.set(students).whenComplete(() {
      print("$Name Successfully Added");
    });
  }

  Future<void> readUser() async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('MyUsers');

    final snapshot =
        await users.get(); // Fetch all documents from the collection
    if (snapshot.docs.isNotEmpty) {
      snapshot.docs.forEach((doc) {
        final data = doc.data() as Map<String, dynamic>;
        final name = data['Name'];
        final age = data['age'];
        print('Name: $name, Age: $age');
      });
    } else {
      print("No users found.");
    }

    // final snapshot = await users.get();
    // snapshot.docs.forEach((doc) {
    //   final data = doc.data() as Map<String, dynamic>; // Cast to a Map for easy access
    //   final name = data['name'];
    //   final age = data['age'];
    //   print('Name: $name, Age: $age');
    //   print(doc.data());
    // });

    // DocumentReference users = FirebaseFirestore.instance.collection('MyUsers').doc(Name);
    // final snapshot = await users.get();
    //
    //
    // if (snapshot.docs.isNotEmpty) {
    //   snapshot.docs.forEach((doc) {
    //     final data = doc.data() as Map<String, dynamic>;
    //     final name = data['Name'];
    //     final age = data['age'];
    //     print('Name: $name, Age: $age');
    //   });
    // } else {
    //   print("No users found.");
    // }
    //
    //
    // // if(snapshot.exists) {
    // //   final data = snapshot.data() as Map<String, dynamic>;
    // //   final name = data['Name'];
    // //   final age = data['age'];
    // //   print('Name: $name, Age: $age');
    // // } else {
    // // print("Document does not exist.");
    // // }
    // // users.get().then((doc) {
    // //   if (doc.exists) {
    // //     Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
    // //     print("Name: ${data?['Name']}");
    // //     print("Age: ${data?['age']}");
    // //   } else {
    // //     print("Document does not exist");
    // //   }
    // // }).catchError((error) {
    // //   print("Failed to get document: $error");
    // // });
    print("Read User");
  }

  Future<void> updateUser(String docId) async {
    DocumentReference users =
        FirebaseFirestore.instance.collection('MyUsers').doc(Name);

    Map<String, dynamic> students = {"Name": Name, "age": age};

    users.update(students).whenComplete(() {
      print("$Name Successfully Updated");
    });
    print("User updated!");
  }

  Future<void> deleteUser(String docId) async {
    // await users.doc(docId).delete();
    DocumentReference users =
        FirebaseFirestore.instance.collection('MyUsers').doc(Name);
    users.delete().whenComplete(() {
      print("$Name Successfully Deleted");
    });
    print("User deleted!");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Firebase CRUD with Custom Buttons'),
      // ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: width * 0.3,
              height: 50,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  getUserName(value);
                },
                // controller: emailController,
                decoration: InputDecoration(
                  hintText: "Enter Your Name",
                  hintStyle: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                  contentPadding: EdgeInsets.only(left: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: width * 0.3,
              height: 50,
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                onChanged: (age) {
                  getUserAge(age);
                },
                // controller: emailController,
                decoration: InputDecoration(
                  hintText: "Enter Your Age",
                  hintStyle: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w500),
                  contentPadding: EdgeInsets.only(left: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.grey,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                      width: 0.5,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                label: 'Create User',
                onPressed: () {
                  createUser();
                },
              ),
              SizedBox(
                width: 20,
              ),
              CustomButton(
                label: 'Read Users',
                onPressed: () {
                  readUser();
                },
              ),
              SizedBox(
                width: 20,
              ),
              CustomButton(
                label: 'Update User',
                onPressed: () {
                  // Provide a valid doc ID to update
                  updateUser('your_document_id');
                },
              ),
              SizedBox(
                width: 20,
              ),
              CustomButton(
                label: 'Delete User',
                onPressed: () {
                  // Provide a valid doc ID to delete
                  deleteUser('your_document_id');
                },
              ),
            ],
          ),
          // StreamBuilder(
          //     stream: FirebaseFirestore.instance
          //         .collection('MyUsers')
          //         .snapshots(),
          //     builder: (context, snapshot) {
          //       if (snapshot.hasData) {
          //         return ListView.builder(
          //             itemCount: snapshot.data!.docs.length,
          //             itemBuilder: (context, index) {
          //               DocumentSnapshot documentSnapshots =
          //                   snapshot.data!.docs[index];
          //               return Row(
          //                 children: [
          //                   Expanded(
          //                       flex: 1,
          //                       child: Text(documentSnapshots["Name"]))
          //                 ],
          //               );
          //             });
          //       }
          //     })
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('MyUsers').snapshots(),
                builder: (context, snapshot) {
                  // Check for different states of the snapshot
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator()); // Show loading indicator while data is loading
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}')); // Handle error case
                  } else if (snapshot.hasData) {
                    // Check if there is data available
                    return Center(
                      child: Container(
                        width: width,
                        height: height * 0.2,
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot documentSnapshots = snapshot.data!.docs[index];
                            return Row(
                              children: [
                                Text("${index + 1}."),
                                SizedBox(width: 5,),
                                Text("User Name : ${documentSnapshots["Name"] ?? 'No Name'} ,"),
                                SizedBox(width: 10,),
                                Text("User Age : ${(documentSnapshots["age"] ?? 'No Age').toString()
                                }"),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return Center(child: Text('No data available')); // Handle no data case
                  }
                },
              ),
            ],
          )

        ],
      ),
    );
  }
}
