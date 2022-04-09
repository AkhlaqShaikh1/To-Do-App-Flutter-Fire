import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  static String id = "/home";
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptController = TextEditingController();

  addTodo() async {
    if (titleController.text != "" && descriptController.text != "") {
      var time = DateTime.now();

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection("myTasks")
          .doc(time.toString())
          .set({
        'title': titleController.text,
        'description': descriptController.text,
        'time': time.toString(),
        'timestamp': time,
      });
      titleController.clear();
      descriptController.clear();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Task Added "),
        duration: Duration(seconds: 3),
      ));
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("No title or description added"),
        ),
      );
    }
  }

  String uid = '';
  @override
  void initState() {
    super.initState();
    getuid();
  }

  getuid() async {
    User? user = FirebaseAuth.instance.currentUser;
    // uid = user!.uid;
    setState(() {
      uid = user!.uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: background,
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('myTasks')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text("Loading");
            }
            if (!snapshot.hasData) {
              return const ScaffoldMessenger(child: Text("Cancelled"));
            } else {
              final docs = snapshot.data!.docs;
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "My Tasks",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: docs.length,
                        itemBuilder: (context, index) {
                          var time =
                              (docs[index]['timestamp'] as Timestamp).toDate();
                          return ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              Container(
                                padding: const EdgeInsets.only(top: 8),
                                margin: const EdgeInsets.only(top: 14),
                                height: 110,
                                decoration: BoxDecoration(
                                  color: Colors.blueGrey.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ListTile(
                                  title: Text(
                                    docs[index]['title'],
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    docs[index]['description'] +
                                        "\n" +
                                        DateFormat.yMd().add_jm().format(time),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                    ),
                                  ),
                                  trailing: IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () async {
                                        await FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(uid)
                                            .collection('myTasks')
                                            .doc(docs[index]['time'])
                                            .delete();
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          const SnackBar(
                                            content: Text(" Task Deleted! "),
                                          ),
                                        );
                                      }),
                                ),
                              )
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          splashColor: Colors.white,
          onPressed: () {
            setState(() {
              addTodosBox();
            });
          },
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }

  addTodosBox() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: const Text("Add Todo"),
            content: SizedBox(
              height: 200,
              width: 400,
              child: Column(
                children: [
                  TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                      hintText: "Title",
                    ),
                  ),
                  TextField(
                    controller: descriptController,
                    decoration: const InputDecoration(
                      hintText: "Description",
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          // maximumSize: MaterialStateProperty.all(Size(30, 30)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.lightBlue),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text("Cancel"),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          // maximumSize: MaterialStateProperty.all(Size(30, 30)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.lightBlue),
                        ),
                        onPressed: addTodo,
                        child: const Text("Add"),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  description(text) {
    return Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold),
    );
  }
}
