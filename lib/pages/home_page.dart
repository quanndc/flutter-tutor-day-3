import 'package:flutter/material.dart';
import 'package:flutter_buoi_2/data/database.dart';
import 'package:flutter_buoi_2/widgets/todo_item.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TodoDatabase db = TodoDatabase();

  TextEditingController titleController = TextEditingController();
  TextEditingController subtitleController = TextEditingController();


  void _addTodo() {
    // print(titleController.text);
    // print(subtitleController.text);
    setState(() {
      db.todos.add({
        'title': titleController.text,
        'subtitle': subtitleController.text,
        'isChecked': false,
      });
      titleController.clear();
      subtitleController.clear();
    });
    db.updateData();
  }

  void _checkDone(int index){
    setState(() {
      db.todos[index]['isChecked'] = !db.todos[index]['isChecked'];
    });
    db.updateData();
  }

  void _removeTodo(int index){
    setState(() {
      db.todos.removeAt(index);
    });
    db.updateData();
  }

  void _openDialog(){
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(

          title: const Text('Add Todo'),
          content: Column(
            spacing: 20,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  hintText: 'Title...',
                  border: OutlineInputBorder(),
                ),
              ),
              TextField(
                controller: subtitleController,
                decoration: const InputDecoration(
                  hintText: 'Subtitle...',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addTodo();
                Navigator.of(context).pop();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    if(db.box.get('todoList') == null){
      db.initData();
    } else{
      db.loadData();
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _openDialog();
        },
        child: const Icon(Icons.add),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: db.todos.length,
          itemBuilder: (context, index) {
            return TodoItem(
              title: db.todos[index]['title'],
              subtitle: db.todos[index]['subtitle'],
              isChecked: db.todos[index]['isChecked'],
              checkDone: () {
                _checkDone(index);
              },
              removeTodo: (context) {
                _removeTodo(index);
              },
            );
          },
        )
      )
    );
  }
}
