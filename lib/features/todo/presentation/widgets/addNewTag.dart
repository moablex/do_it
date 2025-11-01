import 'package:flutter/material.dart';

Future<String?> addNewTag(BuildContext context) {
  final TextEditingController tagController = TextEditingController();

  return showModalBottomSheet<String>(
    useRootNavigator: true,

    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return SizedBox(
        height: 200,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20,
            top: 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add Tag',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: tagController,
                decoration: InputDecoration(
                  labelText: "Add New Tag",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context, tagController.text.trim());
                },
                child: const Text(
                  'Add Tag',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      );
    },
  );
}
