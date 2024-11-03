import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:plaza_libre/auth/plazalibre.dart';
import 'package:provider/provider.dart';
import 'package:plaza_libre/core/providers/productProvider.dart';

void main() async{

WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( 
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>ProductProvider())
      ],
      child: MyApp(),
    )
  );
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {

@override
  Widget build(BuildContext context){
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Plaza Libre',
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
    home: PlazaLibreHomePage(),
  );
}

}
 
