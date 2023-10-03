import 'package:uuid/uuid.dart';

const uuid = Uuid();

class Todo {
  Todo({required this.title, required this.content})
      : status = false,
        id = uuid.v4();
  final String id;
  String title;
  bool status;
  String content;
}
