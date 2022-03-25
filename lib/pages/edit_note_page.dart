import 'package:flutter/material.dart';
import '../db/checkListDatabase.dart';
import '../model/checkListData.dart';
import '../widgets/check_lists.dart';

class AddEditNotePage extends StatefulWidget {
  final CheckListCategory? note;

  const AddEditNotePage({
    Key? key,
    this.note,
  }) : super(key: key);

  @override
  _AddEditNotePageState createState() => _AddEditNotePageState();
}

class _AddEditNotePageState extends State<AddEditNotePage> {
  final _formKey = GlobalKey<FormState>();

  // late bool isImportant;
  // late int number;
  // late String title;
  late String category;

  @override
  void initState() {
    super.initState();
    category = widget.note?.category ?? '';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [buildButton()],
        ),
        body: Form(
          key: _formKey,
          child: NoteFormWidget(
            category: category,
            onChangedCategory: (category) =>
                setState(() => this.category = category),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddEditNotePage()),
            );

            //add refresh opration;
          },
        ),
      );

  Widget buildButton() {
    final isFormValid = category.isNotEmpty && category.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: addOrUpdateNote,
        child: Text('Save'),
      ),
    );
  }

  void addOrUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await updateNote();
      } else {
        await addNote();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateNote() async {
    final note = widget.note!.copy(
      category: category,
    );

    await NotesDatabase.instance.update(note);
  }

  Future addNote() async {
    final note = CheckListCategory(
      category: category,
      createdTime: DateTime.now(),
    );

    await NotesDatabase.instance.create(note);
  }
}
