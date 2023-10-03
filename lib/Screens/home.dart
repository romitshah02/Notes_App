import 'dart:math';

import 'package:flutter/material.dart';
import 'package:todo_list/constants/colors.dart';
import 'package:todo_list/data/user_todo.dart';
import 'package:todo_list/Screens/addtodo.dart';
import 'package:todo_list/models/todo.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Todo> filteredList = [];
  @override
  void initState() {
    super.initState();
    filteredList = userTodo;
  }

  getRandomcolor() {
    Random random = Random();
    return backgroundColors[random.nextInt(backgroundColors.length)];
  }

  changeContent(Todo item) async {
    final index = userTodo.indexOf(item);
    final result = await Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return TodoDetails(
          item: item,
        );
      },
    ));

    if (result != null) {
      setState(() {
        if (result[0] != '') {
          userTodo[index].title = result[0];
        }
        if (result[1] != '') {
          userTodo[index].content = result[1];
        }
        filteredList = userTodo;
      });
    }
  }

  newNote() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const TodoDetails();
        },
      ),
    );

    setState(() {
      if (result != null) {
        userTodo.add(Todo(title: result[0], content: result[1]));
      }
      filteredList = userTodo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Your Notes'),
        actions: [IconButton(onPressed: newNote, icon: const Icon(Icons.add))],
      ),
      body: filteredList.isEmpty
          ? const Center(
              child: Text('No Todo\'s present'),
            )
          : Padding(
              padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
              child: ScrollConfiguration(
                behavior:
                    ScrollConfiguration.of(context).copyWith(scrollbars: false),
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        changeContent(filteredList[index]);
                      },
                      child: Card(
                        elevation: 10,
                        margin: const EdgeInsets.only(bottom: 20),
                        color: getRandomcolor(),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                filteredList[index].title,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: const TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(filteredList[index].content,
                                  overflow: TextOverflow.ellipsis, maxLines: 1),
                              const SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          userTodo.remove(filteredList[index]);
                                          filteredList = userTodo;
                                        });
                                      },
                                      icon: const Icon(Icons.delete),
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
