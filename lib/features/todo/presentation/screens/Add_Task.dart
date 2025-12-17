import 'package:do_it/features/todo/domain/models/todo.dart';
import 'package:do_it/features/todo/presentation/block/todo_cubit.dart';
import 'package:do_it/features/todo/presentation/widgets/Date_Picker.dart';
import 'package:do_it/features/todo/presentation/widgets/addNewTag.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class AddTask extends StatefulWidget {
  const AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  //Variable Initializations for a task class
  //*********************************************************
  //*********************************************************
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController DescriptionController = TextEditingController();
  // List of predefined tag categories
  List<String> taskCategories = [
    'Work',
    'Study',
    'Health',
    'Spritual',
    'Spriual',
  ];
  //List of selected tags from taskCategories
  List<String> SelectedCategories = [];
  DateTime reminderDate = DateTime.now();
  TimeOfDay reminderTime = TimeOfDay.now();
  bool setReminder = false;
  DateTime? startTime;
  DateTime? endTime;
  // A function to update start and end time as it changed
  void _onDateRangeChanged(DateTimeRange newRange) {
    setState(() {
      startTime = newRange.start;
      endTime = newRange.end;
    });
  }

  //Reminder Date and Time picker functions
  Future<void> _selectRemiderDate() async {
    final DateTime? remiderDatePicked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2026),
    );
    if (remiderDatePicked != null && remiderDatePicked != reminderDate) {
      setState(() {
        reminderDate = remiderDatePicked;
      });
    }
  }

  //Select reminder time
  Future<void> _selectReminderTime() async {
    final TimeOfDay? pickedReminderTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedReminderTime != null && pickedReminderTime != reminderTime) {
      setState(() {
        reminderTime = pickedReminderTime;
      });
    }
  }

  //Generate unigue ID for each task
  final _uuid = Uuid();
  String _generateTaskId() {
    return _uuid.v4();
  }

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
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    // color: const Color.fromARGB(255, 200, 215, 240),
                  ),
                  child: TextFormField(
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: 'Physical Exercises',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: Icon(Icons.title_outlined),

                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: 16.0, color: Colors.black87),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please add Title';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(15),
                  //   color: const Color.fromARGB(255, 200, 215, 240),
                  // ),
                  child: TextFormField(
                    maxLines: 4,
                    maxLength: 4,
                    controller: DescriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      prefixIcon: Icon(Icons.description),

                      filled: true,
                      fillColor: Colors.grey[100],
                    ),
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    style: TextStyle(fontSize: 16.0, color: Colors.black87),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Describe your task';
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
                SizedBox(height: 10),
                DateRangeSelector(assignNewDateRange: _onDateRangeChanged),

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
                Visibility(
                  visible: setReminder,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          // Date Picker Button
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal.shade50,
                                foregroundColor: Colors.teal,
                                elevation: 0,
                              ),
                              onPressed: () => _selectRemiderDate(),
                              icon: const Icon(Icons.calendar_today),
                              label: Text(
                                DateFormat(
                                  'EEE, MMM d',
                                ).format(reminderDate).toString(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 10),
                      // Time Picker Button
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal.shade50,
                                foregroundColor: Colors.teal,
                                elevation: 0,
                              ),
                              onPressed: () => _selectReminderTime(),
                              icon: const Icon(Icons.access_time),
                              label: Text(
                                reminderTime.format(context).toString(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                    onPressed: () {
                      _formKey.currentState!.validate();
                      // Combine Date and Time for the Reminder
                      DateTime? finalReminderDateTime;
                      if (setReminder) {
                        //combine the selected reminder date with time
                        finalReminderDateTime = reminderDate.copyWith(
                          hour: reminderTime.hour,
                          minute: reminderTime.minute,
                        );
                      }
                      final task = Task(
                        id: _generateTaskId(),
                        title: titleController.text.trim(),
                        description: DescriptionController.text.trim(),
                        isCompleted: false,
                        tags: SelectedCategories,
                        subTasks: [],
                        reminderTime: finalReminderDateTime,
                      );
                      context.read<TodoCubit>().addTask(task);
                    },
                    label: Text('Add', style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
