import 'package:flutter/material.dart';

class NoteFormWidget extends StatelessWidget {
  final String? category;
  final String? description;
  final ValueChanged<String> onChangedCategory;

  const NoteFormWidget({
    Key? key,
    this.category = '',
    this.description = '',
    required this.onChangedCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              SizedBox(height: 8),
              buildDescription(),
              SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: category,
        style: const TextStyle(
          color: Colors.white70,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Title',
          hintStyle: const TextStyle(color: Colors.white70),
        ),
        validator: (title) => title != null && title.isEmpty
            ? 'The category cannot be empty'
            : null,
        onChanged: onChangedCategory,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: description,
        style: const TextStyle(color: Colors.white60, fontSize: 18),
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Type something...',
          hintStyle: TextStyle(color: Colors.white60),
        ),
      );
}
