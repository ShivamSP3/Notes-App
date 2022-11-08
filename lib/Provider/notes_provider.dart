// ignore_for_file: unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:notes_app/services/api_services.dart';

import '../Models/note.dart';

class NotesProvider with ChangeNotifier{
  bool isLoaded = true;
 static List<Note> notes =[];
 NotesProvider(){
  fetchNotes();
 }
 void sortNotes(){
  notes.sort((a, b) =>b.dateadded!.compareTo(a.dateadded!) );
 }
 static List<Note> getFilteredNotes(String searchQuery){
    return notes.where((element) => element.title!.toLowerCase().contains(searchQuery.toLowerCase())
    || element.content!.toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();
  }
  void addNote(Note note){
    notes.add(note);
    sortNotes();
    notifyListeners();
    ApiService.addNote(note);
  }
  void updateNote(Note note){
    int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
      notes[indexOfNote]= note;
      sortNotes();
      notifyListeners();
      ApiService.addNote(note);
      
  }
  void deleteNote(Note note){
     int indexOfNote = notes.indexOf(notes.firstWhere((element) => element.id == note.id));
      notes.removeAt(indexOfNote);
      sortNotes();
      notifyListeners();
      ApiService.deleteNote(note);
  }
  void fetchNotes()async{
   notes=  await ApiService.fetchNotes("ShivamPrajapati");
   isLoaded = false;
   sortNotes();
   notifyListeners();
  }
}