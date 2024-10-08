import 'package:flutter/material.dart';
import 'package:image_generator/feature/prompt/ui/create_prompt_screen.dart';

void main(){
  runApp( const Myapp());
}

class Myapp extends StatelessWidget{
  const Myapp({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.grey.shade900,
          elevation: 0
        ),
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.grey.shade900
      ),
      home: CreatePromoptScreen(),
    );
  }
}