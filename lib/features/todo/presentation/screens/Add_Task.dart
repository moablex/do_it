import 'package:do_it/features/todo/presentation/widgets/Date_Picker.dart';
import 'package:flutter/material.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController DescriptionController = TextEditingController();
  final taskRepeatInterval = ['Hourly', 'Daily', 'Weakly', 'Monthly'];
  List<String> taskCategories = ['Work', 'Study', 'Health', 'Spritual'];
  bool setReminder = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Center(
          child: Text(
            'Add New Task',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                maxLines: 4,
                maxLength: 4,
                controller: DescriptionController,
                decoration: InputDecoration(
                  hintText: 'Description',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 10),
              DateRangeSelector(),

              SizedBox(height: 20),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Repeat'),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(0, 122, 231, 235),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton(
                          borderRadius: BorderRadius.circular(15),
                          value: taskRepeatInterval[0],
                          items:
                              taskRepeatInterval.map((String interval) {
                                return DropdownMenuItem(
                                  child: Text(interval),
                                  value: interval,
                                );
                              }).toList(),
                          onChanged: (String? Newvalue) {
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Remind Me'),
                  Switch(
                    value: setReminder,
                    onChanged: (bool newValue) {
                      setState(() {
                        setReminder = newValue;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text('Category', style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Wrap(
                    runSpacing: 10,
                    spacing: 5,
                    children:
                        taskCategories.map((category) {
                          return InputChip(label: Text(category));
                        }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Container(
                height: 50,
                width: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: FloatingActionButton.extended(
                  icon: Icon(Icons.add, color: Colors.white),
                  backgroundColor: Colors.teal,
                  onPressed: () {},
                  label: Text('New Tag', style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 50,
                width: 300,

                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    backgroundColor: Colors.teal,
                  ),
                  icon: Icon(color: Colors.white, Icons.add),
                  onPressed: () {},
                  label: Text('Add', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
