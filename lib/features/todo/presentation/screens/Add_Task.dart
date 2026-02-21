import 'package:do_it/features/todo/domain/models/todo.dart';
import 'package:do_it/features/todo/presentation/block/todo_cubit.dart';
import 'package:do_it/features/todo/presentation/block/todo_state.dart';
import 'package:do_it/features/todo/presentation/widgets/Date_Picker.dart';
import 'package:do_it/features/todo/presentation/widgets/Task_categories.dart';
import 'package:do_it/features/todo/presentation/widgets/addNewTag.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/data/app_data.dart';

class AddTask extends StatefulWidget {
  final VoidCallback? onTaskAdded;
  const AddTask({super.key, this.onTaskAdded});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  //Input decoration

  InputDecoration _inputDecoration({
    String? label,
    IconData? icon,
    String? hint,
  }) {
    return InputDecoration(
      labelText: label ?? '',
      hintText: hint ?? '',
      prefixIcon: icon != null ? Icon(icon, color: Colors.teal) : null,
      filled: true,
      fillColor: Colors.grey.shade50,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: const BorderSide(color: Colors.teal, width: 1.5),
      ),
    );
  }

  //Variable Initializations for a task class
  //*********************************************************
  //*********************************************************
  final _formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController DescriptionController = TextEditingController();

  // List of predefined tag categories
  List<TaskCategory> taskCategories = AppData.initialCategory;
  List<String> availableTags = AppData.starterTags;
  //The initial selected task category
  TaskCategory? SelectedTaskCategory;
  //List of selected tags from task tags
  List<String> SelectedTags = [];
  DateTime? startTime;
  DateTime? endTime;
  DateTime reminderDate = DateTime.now();
  TimeOfDay reminderTime = TimeOfDay.now();
  bool setReminder = false;
  DateTime _selectedDateTime = DateTime.now();
  List<String> reminderTimesList = [
    'One Time',
    'Every Day',
    'Every Week',
    'Every Month',
  ];
  String? selectedRepeatTime;
  DateTime? nextDaily;
  DateTime? nextWeekly;
  DateTime? nextMonthly;

  //Calculating the selected Next day,week and month
  DateTime getnextDaily(DateTime? current) {
    if (current != null) {
      return current.add(const Duration(days: 1));
    } else {
      return DateTime.now().add(const Duration(days: 1));
    }
  }

  DateTime getnextWeekly(DateTime? current) {
    if (current != null) {
      return current.add(const Duration(days: 7));
    } else {
      return DateTime.now().add(const Duration(days: 1));
    }
  }

  DateTime getNextMonthly(DateTime? current) {
    if (current != null) {
      return DateTime(current.year, current.month + 1, current.day);
    } else {
      return DateTime(
        DateTime.now().year,
        DateTime.now().month + 1,
        DateTime.now().day,
      );
    }
  }

  // A function to update start and end time as it changed
  void _onDateRangeChanged(DateTimeRange newRange) {
    setState(() {
      startTime = newRange.start;
      endTime = newRange.end;
    });
  }

  //Reminder Date and Time picker functions
  Future<void> _selectReminderDate(BuildContext context) async {
    final DateTime? remiderDatePicked = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );

    if (remiderDatePicked != null && remiderDatePicked != reminderDate) {
      if (!mounted) return;
      _selectReminderTime(context, remiderDatePicked);
    }
  }

  //Select reminder time after date is being selected
  Future<void> _selectReminderTime(
    BuildContext context,
    DateTime ReminderDate,
  ) async {
    final TimeOfDay? pickedReminderTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
    );
    if (pickedReminderTime != null && pickedReminderTime != reminderTime) {
      setState(() {
        _selectedDateTime = DateTime(
          reminderDate.year,
          reminderDate.month,
          reminderDate.day,
          pickedReminderTime.hour,
          pickedReminderTime.minute,
        );
      });
      print('The selected daily schedule is ${_selectedDateTime}');
      switch (selectedRepeatTime) {
        case 'Every Day':
          setState(() {
            nextDaily = getnextDaily(_selectedDateTime);
            print('The selected daily schedule is ${nextDaily}');
          });

          break;
        case 'Every Weak':
          setState(() {
            nextWeekly = getnextWeekly(_selectedDateTime);
            print('The selected weekly schedule is ${nextWeekly}');
          });
        case 'Every Month':
          setState(() {
            nextMonthly = getNextMonthly(_selectedDateTime);
          });
        default:
      }
      print('The selected daily schedule is ${nextDaily}');
    }
  }

  //Generate unigue ID for each task
  final _uuid = Uuid();
  String _generateTaskId() {
    return _uuid.v4();
  }

  @override
  void initState() {
    super.initState();
    // Initialize with a default value
    SelectedTaskCategory = AppData.initialCategory.last;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TodoCubit, TodoState>(
      listenWhen:
          (previous, current) =>
              current is TodoAdditionSuccess || current is TodoAdditionError,
      listener: (context, state) {
        if (state is TodoAdditionSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Task saved successfully !'),
              backgroundColor: Colors.teal,
              behavior: SnackBarBehavior.floating,
            ),
          );
          //  Trigger the callback to switch the tab
          if (widget.onTaskAdded != null) {
            widget.onTaskAdded!();
          }
        } else if (state is TodoAdditionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Unable to save'),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: Scaffold(
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
          physics: BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 20,
                        spreadRadius: 4,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Text(
                            "Task Information",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                              letterSpacing: 0.5,
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: titleController,
                            decoration: _inputDecoration(
                              label: 'Tittle',
                              icon: Icons.title_outlined,
                              hint: 'Physical excercise',
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please add Title';
                              } else {
                                return null;
                              }
                            },
                          ),
                          SizedBox(height: 10),
                          TextFormField(
                            maxLines: 4,
                            maxLength: 100,
                            controller: DescriptionController,
                            decoration: _inputDecoration(
                              label: 'Decription',
                              icon: Icons.description,
                            ),
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            style: TextStyle(
                              fontSize: 16.0,
                              color: Colors.black87,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Add some details ..';
                              } else {
                                return null;
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_rounded,
                            color: Colors.teal,
                            size: 20,
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            "Schedule",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.teal,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Date Range Selector
                      DateRangeSelector(
                        assignNewDateRange: _onDateRangeChanged,
                      ),

                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Divider(
                          color: Color(0xFFF5F5F5),
                          thickness: 1.5,
                        ),
                      ),

                      // Reminder Toggle
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Remind Me",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "Get notified before task",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Switch.adaptive(
                            activeColor: Colors.teal,
                            value: setReminder,
                            onChanged:
                                (val) => setState(() => setReminder = val),
                          ),
                        ],
                      ),
                      AnimatedSize(
                        duration: const Duration(milliseconds: 300),
                        child:
                            setReminder
                                ? Column(
                                  children: [
                                    const SizedBox(height: 16),
                                    DropdownButtonFormField<String>(
                                      decoration: _inputDecoration(
                                        label: 'Repeat Interval',
                                        icon: Icons.repeat_rounded,
                                      ),
                                      value: selectedRepeatTime,
                                      items:
                                          reminderTimesList
                                              .map(
                                                (val) => DropdownMenuItem(
                                                  value: val,
                                                  child: Text(val),
                                                ),
                                              )
                                              .toList(),
                                      onChanged:
                                          (val) => setState(() {
                                            selectedRepeatTime = val;
                                          }),
                                    ),
                                    const SizedBox(height: 12),
                                    InkWell(
                                      onTap: () => _selectReminderDate(context),
                                      borderRadius: BorderRadius.circular(16),
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 16,
                                          horizontal: 16,
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.teal.withValues(
                                            alpha: 0.05,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),
                                          border: Border.all(
                                            color: Colors.teal.withValues(
                                              alpha: 0.01,
                                            ),
                                          ),
                                        ),
                                        child: Row(
                                          children: [
                                            const Icon(
                                              Icons.alarm_rounded,
                                              color: Colors.teal,
                                            ),
                                            const SizedBox(width: 12),
                                            Text(
                                              "Remind at: ${reminderTime.format(context)}",
                                              style: const TextStyle(
                                                color: Colors.teal,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Spacer(),
                                            const Icon(
                                              Icons.arrow_forward_ios_rounded,
                                              size: 14,
                                              color: Colors.teal,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                                : const SizedBox.shrink(),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 16.0,
                  ),
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      const Text(
                        'Category',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.teal,
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        height: 50,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext, int index) {
                            final category = taskCategories[index];
                            final isSelected = SelectedTaskCategory == category;
                            return ChoiceChip(
                              backgroundColor: Colors.grey.shade50,
                              labelStyle: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.blueGrey,
                                fontWeight:
                                    isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color:
                                      isSelected
                                          ? Colors.teal
                                          : Colors.grey.shade200,
                                ),
                              ),
                              showCheckmark: false,
                              label: Text(category.name),
                              selected: isSelected,
                              onSelected: (bool selected) {
                                setState(() {
                                  SelectedTaskCategory =
                                      selected ? category : null;
                                });
                              },
                            );
                          },
                          separatorBuilder:
                              (context, index) => const SizedBox(width: 10),
                          itemCount: taskCategories.length,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),
                Text('Tags', style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Flexible(
                      child: Wrap(
                        alignment: WrapAlignment.start,
                        runSpacing: 10,
                        spacing: 5,
                        children:
                            availableTags.map((Tag) {
                              return InputChip(
                                selected: SelectedTags.contains(Tag),
                                selectedShadowColor: Colors.blueGrey,
                                label: Text(Tag),
                                selectedColor: Colors.teal,
                                onSelected: (value) {
                                  setState(() {
                                    if (value) {
                                      SelectedTags.add(Tag);
                                    } else {
                                      SelectedTags.remove(Tag);
                                    }
                                  });
                                },
                              );
                            }).toList(),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 16.0,
                      ),
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Header with Title and "Add" Action
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Tags",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.teal,
                                ),
                              ),
                              TextButton.icon(
                                onPressed: () async {
                                  final newTag = await addNewTag(context);
                                  if (newTag != null) {
                                    setState(() {
                                      availableTags.add(newTag);
                                      SelectedTags.add(newTag);
                                    });
                                  }
                                },
                                icon: const Icon(Icons.add, size: 18),
                                label: const Text("New Tag"),
                                style: TextButton.styleFrom(
                                  foregroundColor: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // The Tag Wrap
                          Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children:
                                availableTags.map((tag) {
                                  final isSelected = SelectedTags.contains(tag);
                                  return FilterChip(
                                    label: Text(tag),
                                    selected: isSelected,
                                    onSelected: (bool value) {
                                      setState(() {
                                        if (value) {
                                          SelectedTags.add(tag);
                                        } else {
                                          SelectedTags.remove(tag);
                                        }
                                      });
                                    },
                                    // Visual Styling
                                    showCheckmark: true,
                                    checkmarkColor: Colors.white,
                                    selectedColor: Colors.teal,
                                    backgroundColor: Colors.grey.shade100,
                                    labelStyle: TextStyle(
                                      color:
                                          isSelected
                                              ? Colors.white
                                              : Colors.blueGrey.shade700,
                                      fontWeight:
                                          isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 8,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      side: BorderSide(
                                        color:
                                            isSelected
                                                ? Colors.teal
                                                : Colors.grey.shade200,
                                      ),
                                    ),
                                  );
                                }).toList(),
                          ),
                        ],
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
                              availableTags.add(newTag);
                              SelectedTags.add(newTag);
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
                      if (_formKey.currentState!.validate()) {
                        //create the new task object
                        final task = Task(
                          id: _generateTaskId(),
                          title: titleController.text.trim(),
                          description: DescriptionController.text.trim(),
                          isCompleted: false,
                          tags: SelectedTags,
                          subTasks: [],
                          startTime: startTime ?? null,
                          endTime: endTime ?? null,
                          reminderTime:
                              _selectedDateTime != DateTime.now()
                                  ? _selectedDateTime
                                  : null,
                        );
                        //Save the new task to local storage
                        context.read<TodoCubit>().addTask(task);
                      }
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
