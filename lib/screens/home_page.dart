import 'package:firebase_to_do_app/models/to_do_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  String? check(String? text) {
    if (text!.isEmpty) {
      return "Field can't be empty";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text("TO-DO's"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(8.0),
                child: TextFormField(
                  validator: check,
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Title",
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.all(8.0),
                // width: ,
                child: TextFormField(
                  controller: descriptionController,
                  validator: check,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Description",
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_key.currentState!.validate()) {
                    ToDo newTodo = ToDo(
                        isCompleted: false,
                        title: titleController.text,
                        description: descriptionController.text);
                    todo.add(newTodo);
                    FocusManager.instance.primaryFocus?.unfocus();
                    setState(() {});
                  }
                },
                child: const Text("Add TO-DO"),
              ),
              const SizedBox(height: 15),
              toDoTile(),
            ],
          ),
        ),
      ),
    );
  }

  Widget toDoTile() {
    return SingleChildScrollView(
      child: ListView.builder(
        // scrollDirection: Axis.vertical,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap:
            true, // use this to remove errors of listview inside of column
        itemCount: todo.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  offset: Offset(1, 1),
                  spreadRadius: 1,
                  blurRadius: 15,
                  color: Colors.black26,
                ),
                BoxShadow(
                  offset: Offset(2, 10),
                  spreadRadius: 1,
                  blurRadius: 15,
                  color: Colors.black26,
                ),
              ],
            ),
            width: 200,
            height: 150,
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              title: Text(todo[index].title),
              subtitle: Text(todo[index].description),
            ),
          );
        },
      ),
    );
  }
}
