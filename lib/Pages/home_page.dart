// ignore_for_file: prefer_const_constructors, prefer_is_empty

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/Provider/notes_provider.dart';
import 'package:provider/provider.dart';
import '../Models/note.dart';
import 'add_note.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String searchQuery="";
  @override
  Widget build(BuildContext context) {
    NotesProvider notesProvider = Provider.of<NotesProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text("Notes App"),centerTitle: true,
        ),
        body: (notesProvider.isLoaded == false) ? SafeArea(
          child:(NotesProvider.notes.length > 0) ? ListView(
           children : [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery=value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Search",
                  prefixIcon: Icon(Icons.search),
                  focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(width: 1.5, color: Colors.pink),),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                  )
                ),
              ),
            ),
            
         ( NotesProvider.getFilteredNotes(searchQuery).length > 0) ?  GridView.builder(
               shrinkWrap: true,
               physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
               itemCount: NotesProvider.getFilteredNotes(searchQuery).length,
               itemBuilder: (context, index) {
                Note currentNote = NotesProvider.getFilteredNotes(searchQuery)[index];
                 return GestureDetector(
                  onTap: () {
                    // update
                    Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => AddNewPage(isUpdate: true,note: currentNote,))
                    );
                  },
                  onLongPress: () {
                    // Delete
                    notesProvider.deleteNote(currentNote);
                  },
                   child: Container(
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(10),
                   decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.amber)
                   ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(currentNote.title!,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,),
                        maxLines: 2,overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 5,),
                        Text(currentNote.content!,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 18),
                        maxLines: 5,overflow: TextOverflow.ellipsis,),
                      ],
                    ),
                   ),
                 );
               },
               ): Padding(
                 padding: const EdgeInsets.all(20.0),
                 child: Center(child: Text("Oops , No Notes Found!"),),
               )
               ]
          ) : Center(child: Text("No Notes to show ",style: TextStyle(fontSize: 30),),)
      ): Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
         Navigator.push(context, 
         CupertinoPageRoute(
          fullscreenDialog: true,
          builder: (context) => const AddNewPage(isUpdate: false,),)
         );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}