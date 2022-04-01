import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:my_checklist/pages/add_check_list_page.dart';
import '../db/checkListDatabase.dart';
import '../model/checkListData.dart';
import '../widgets/check_list.dart';

class NoteDetailPage extends StatefulWidget {
  final int noteId;
 late CheckLists? ckList;

   NoteDetailPage({
    Key? key,
    required this.noteId,
     this.ckList,
  }) : super(key: key);

  get checkLi => null;

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late CheckListCategory category;
  late List<CheckLists> checkList;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
category = CheckListCategory(createdTime: DateTime.now(),category: 'test', id: 1);

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    checkList = await NotesDatabase.instance.readCheckLists(widget.noteId);
    category = await NotesDatabase.instance.readCategory(widget.noteId);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          actions: [deleteButton()],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(12),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      category.category,
                      style:  TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      DateFormat.yMMMd().format(category.createdTime),
                      style: TextStyle(color: Colors.white60),
                    ),

                    Column(
                        children: checkList.map((list) {
                          return CheckboxListTile(
                            activeColor: Colors.white,
                              checkColor: Colors.black,
                              value: list.checkListSatus,
                              autofocus: true,
                              title: Text(list.checkList, style: TextStyle(color: Colors.white),),
                          onChanged: (bool? value) { onchamgersd(list); });
                        }).toList(),
                    ),
                  ],
                ),
              ),
        floatingActionButton: FloatingActionButton (
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddCheckListPage(categoryId: category.id!),)
            );
            refreshNote();
          },
        ),
      );

  Future onchamgersd(CheckLists list) async {
    widget.ckList = list;
    final note = widget.ckList?.copy(checkListStatus: true);
    print(note);

    await NotesDatabase.instance.updateCheckList(note!);
    refreshNote();
  }

  Widget deleteButton() => IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await NotesDatabase.instance.delete(widget.noteId);
          Navigator.of(context).pop();
        },
      );
}
