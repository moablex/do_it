import 'package:flutter/material.dart';

class SearchTask extends StatelessWidget {
  const SearchTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(),
    );
  }
}
