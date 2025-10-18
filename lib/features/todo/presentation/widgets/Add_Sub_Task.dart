import 'package:flutter/material.dart';

class AddSubTask extends StatelessWidget {
  AddSubTask();

  void _showSubTaskModal(BuildContext context) {
    final TextEditingController tileController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: 20),
              Text("Add Sub Task"),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: tileController,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                    labelText: "Subtask title",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Colors.blue, width: 10),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: "Subtask Description",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(color: Colors.blue, width: 10),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(onPressed: () {}, child: Text("Cancel")),
                  TextButton(onPressed: () {}, child: Text("Save")),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color?>(Colors.yellow),
      ),
      onPressed: () {
        _showSubTaskModal(context);
      },
      icon: Icon(Icons.add),
      label: Text('Add subTask'),
    );
  }
}
