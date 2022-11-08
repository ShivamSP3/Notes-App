// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:notes_app/Models/note.dart';
import 'package:notes_app/Provider/notes_provider.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddNewPage extends StatefulWidget {
   final bool isUpdate ;
 final Note? note;
  const AddNewPage({super.key, required this.isUpdate, this.note});

  @override
  State<AddNewPage> createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewPage> {

  FocusNode noteFocus = FocusNode();
  
   TextEditingController titleController = TextEditingController();
   TextEditingController contentController = TextEditingController();

    void addNewNote(){
    Note newNote = Note(
      id: Uuid().v1(),
      userid: "ShivamPrajapati",
      title: titleController.text,
      content: contentController.text,
      dateadded: DateTime.now()
    );
    Provider.of<NotesProvider>(context,listen: false).addNote(newNote);
    Navigator.pop(context);
    }
    void updateNote(){
            // update
                widget.note!.title = titleController.text;
                widget.note!.content = contentController.text;
                widget.note!.dateadded= DateTime.now();
                Provider.of<NotesProvider>(context, listen: false).updateNote(widget.note!);
                Navigator.pop(context);
    }
    @override
  void initState() {
    // TODO: implement initState
   if(widget.isUpdate){
    titleController.text = widget.note!.title!;
    contentController.text = widget.note!.content!;

   }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {
              if(widget.isUpdate){
             updateNote();
              }else{
              addNewNote();
              }
          }, icon: Icon(Icons.check))
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
          child: Column(
            children: [
              TextField(
                onSubmitted:(value) {
                  if(value!=""){
                    noteFocus.requestFocus();
                  }
                } ,
                autofocus: (widget.isUpdate == true) ? false :true,
                controller: titleController,
                  style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                  hintText: "Title",
                  border: InputBorder.none,
                  
                  ),
              ),
              
              Expanded(
                  child: TextField(
                    controller: contentController,
                    focusNode: noteFocus,
                    maxLines: null,
                    style: TextStyle(fontSize: 20),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    hintText: "Note...",
                    hintMaxLines: 5
                    ),
                  ),
                )
            ],

          ),
        ),
      ),
    );
  }
}