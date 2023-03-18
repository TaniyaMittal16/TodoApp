import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoCard extends  StatefulWidget {
  const TodoCard({super.key});

  _TodoCardState createState() => _TodoCardState();
}
class _TodoCardState extends State<TodoCard> {
  final List<String> _todoCard = <String>[];
  final TextEditingController _textFieldController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  String? get description => null;

  String? get title => null;

  String? get date => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: ListView(children: _getItems()),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Add Items',
          child: Icon(Icons.add)),
    );
  }

  void _addTodoItem(String title, String description, String date) {
    setState(() {
      _todoCard.add(title);
      _todoCard.add(description);
      _todoCard.add(date);
    });
    _textFieldController.clear();
    _descriptionController.clear();
    _dateController.clear();
  }

  // Generate list of item widgets
  Widget _buildTodoItem(String title, String description, String date) {
    return ListTile(title: Text(title,  semanticsLabel: description));
  }

  // Generate a single item widget
  Future<Future> _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a task to your list'),
            content: Column(
              children: [
                TextField(
                  controller: _textFieldController,
                  decoration: const InputDecoration(hintText: 'Enter Task here'),
                ),
                TextField(
                  controller: _descriptionController,
                  decoration: const InputDecoration(hintText: 'Enter Description here'),
                ),
                TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.calendar_today),
                    labelText: 'Enter Date'
                  ),
                  readOnly: true,
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(1920),
                      lastDate: DateTime(2025),
                    );
                    if(pickedDate != null) {
                      print(pickedDate);
                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(formattedDate);
                      setState(() {
                        _dateController.text = formattedDate;
                      });
                    } else {}
                  },
                )
              ],
            ),

            actions: <Widget>[
              ElevatedButton(
                child: const Text('ADD'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(_textFieldController.text, _descriptionController.text, _dateController.text);
                },
              ),
              ElevatedButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  List<Widget> _getItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    for (String title in _todoCard) {
      _todoWidgets.add(_buildTodoItem(title, description ?? "" , date ?? ""));
    }
    return _todoWidgets;
  }
}






