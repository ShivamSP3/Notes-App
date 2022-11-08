// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:notes_app/Pages/home_page.dart';
import 'package:notes_app/Provider/notes_provider.dart';
import 'package:provider/provider.dart';

void main(){

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => NotesProvider(),
        )
      ],
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    ),
      );
  }
}