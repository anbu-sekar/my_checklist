
import 'package:flutter/material.dart';
import '../db/checkListDatabase.dart';
import '../model/checkListData.dart';
import '../widgets/check_list.dart';
import '../widgets/check_lists.dart';

class AddCheckListPage extends StatefulWidget {
  final int categoryId;
  final String? checkList;

  const AddCheckListPage({
    Key? key,
    required this.categoryId,
    this.checkList,
    }) : super(key: key);

  @override
  State<AddCheckListPage> createState() => _AddCheckListPageState();
}


class _AddCheckListPageState extends State<AddCheckListPage> {
  final _formKey = GlobalKey<FormState>();

  late String checkListEntered;

  @override
  void initState() {
    super.initState();
    checkListEntered = '';

  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        title: Text('Add Check Lists'),
        actions: [buildButton()],
      ),
      body:  Form(
        key: _formKey,
        child: NoteFormWidget(
          category: checkListEntered,
          onChangedCategory: (enteredText) =>
              setState(() => this.checkListEntered = enteredText),
        ),
      ),

  );

  Widget buildButton() {
    final isFormValid = checkListEntered.isNotEmpty && checkListEntered.isNotEmpty;

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
      await addCheckList();


    }
    Navigator.pop(context);
  }

  Future addCheckList() async {
    final addingCheckList = CheckLists(
        categoryId: widget.categoryId,
        checkList: checkListEntered,
        checkListSatus: false,
        createdTime: DateTime.now());
    await NotesDatabase.instance.createCheckList(addingCheckList);
    Navigator.of(context).pop();
  }

  Widget checkListTitle() => TextFormField(
    maxLines: 1,
    initialValue: this.checkListEntered,
    style: const TextStyle(
      color: Colors.white70,
      fontWeight: FontWeight.bold,
      fontSize: 24,
    ),
    decoration: const InputDecoration(
      border: InputBorder.none,
      hintText: 'Enter Category',
      hintStyle: const TextStyle(color: Colors.white70),
    ),
  );

}
