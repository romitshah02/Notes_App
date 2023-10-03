import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';

class TodoDetails extends StatefulWidget {
  const TodoDetails({super.key, this.item});

  final Todo? item;

  @override
  State<TodoDetails> createState() => _TodoDetailsState();
}

class _TodoDetailsState extends State<TodoDetails> {
  var title = TextEditingController();
  var content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(top: 40, left: 16, right: 16),
        child: Column(
          children: [
            Expanded(
                child: Form(
              child: Column(
                children: [
                  TextField(
                    maxLines: null,
                    controller: title,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintMaxLines: 2,
                        hintText:
                            widget.item != null ? widget.item!.title : 'Title',
                        hintStyle: const TextStyle(
                          overflow: TextOverflow.visible,
                          color: Colors.black,
                          fontSize: 30,
                        )),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                    ),
                  ),
                  TextField(
                    maxLines: null,
                    controller: content,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintMaxLines: null,
                        hintText: widget.item != null
                            ? widget.item!.content
                            : 'Content',
                        hintStyle: const TextStyle(
                          overflow: TextOverflow.visible,
                          color: Colors.black,
                          fontSize: 15,
                        )),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, [title.text, content.text]);
        },
        backgroundColor: Colors.grey[800],
        elevation: 10,
        child: const Icon(Icons.save),
      ),
    );
  }
}
