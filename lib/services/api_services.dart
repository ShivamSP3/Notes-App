// ignore_for_file: prefer_final_fields, unused_field, prefer_interpolation_to_compose_strings
import 'dart:convert';
import 'dart:developer';

import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:http/http.dart' as http;
import '../Models/note.dart';

class ApiService{
  static String _baseUrl = "https://guarded-reef-85971.herokuapp.com/notes";
 
 static Future<void> addNote(Note note)async{
    Uri  requestUri = Uri.parse(_baseUrl + "/add");
    var response =   await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }
   static Future<void> deleteNote(Note note)async{
    Uri  requestUri = Uri.parse(_baseUrl + "/delete");
    var response =   await http.post(requestUri, body: note.toMap());
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
  }
  static Future<List<Note>> fetchNotes(String userid)async{
     Uri  requestUri = Uri.parse(_baseUrl + "/list");
    var response =   await http.post(requestUri, body: {"userid" : userid});
    var decoded = jsonDecode(response.body);
    log(decoded.toString());
    List<Note> notes = [];
    for(var noteMap in decoded){
      Note newNote = Note.fromMap(noteMap);
      notes.add(newNote);
    }
    return notes;
  }

}