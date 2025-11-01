import 'package:do_it/features/todo/presentation/widgets/Date_Picker.dart';
import 'package:do_it/features/todo/presentation/widgets/addNewTag.dart';
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
  List<String> taskCategories = [
    'Work',
    'Study',
    'Health',
    'Spritual',
    'Spriual',
  ];

  List<String> SelectedCategories = [];
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
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  // color: const Color.fromARGB(255, 200, 215, 240),
                ),
                child: TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                    labelText: 'Title',
                    hintText: 'Physical Exercises',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.title_outlined),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        // Clear the text field
                      },
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 16.0, color: Colors.black87),
                ),
              ),
              SizedBox(height: 20),
              Container(
                // decoration: BoxDecoration(
                //   borderRadius: BorderRadius.circular(15),
                //   color: const Color.fromARGB(255, 200, 215, 240),
                // ),
                child: TextField(
                  maxLines: 4,
                  maxLength: 4,
                  controller: DescriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    prefixIcon: Icon(Icons.description),
                    suffixIcon: IconButton(
                      icon: Icon(Icons.clear),
                      onPressed: () {
                        // Clear the text field
                      },
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                  ),
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  style: TextStyle(fontSize: 16.0, color: Colors.black87),
                ),
              ),
              SizedBox(height: 10),
              DateRangeSelector(),

              SizedBox(height: 20),

              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('Remind Me'),
                  Switch(
                    activeColor: Colors.teal,
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
                  Flexible(
                    child: Wrap(
                      alignment: WrapAlignment.start,
                      runSpacing: 10,
                      spacing: 5,
                      children:
                          taskCategories.map((category) {
                            return InputChip(
                              selected: SelectedCategories.contains(category),
                              selectedShadowColor: Colors.blueGrey,
                              label: Text(category),
                              selectedColor: Colors.teal,
                              onSelected: (value) {
                                setState(() {
                                  if (value) {
                                    SelectedCategories.add(category);
                                  } else {
                                    SelectedCategories.remove(category);
                                  }
                                });
                              },
                            );
                          }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                          255,
                          201,
                          236,
                          233,
                        ),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        print("===> Add Tag button tapped");
                        final newTag = await addNewTag(context);
                        setState(() {
                          if (newTag != null) {
                            taskCategories.add(newTag);
                            SelectedCategories.add(newTag);
                          }
                        });
                      },
                      icon: const Icon(Icons.add, weight: 50),
                      label: const Text(
                        'ADD',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                    ),
                  ),
                ],
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
