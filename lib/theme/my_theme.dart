import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';

NeumorphicThemeData myThemeApp() {
  
  final NeumorphicThemeData myTheme = 
  NeumorphicThemeData(
    defaultTextColor: Colors.white,
    baseColor: Colors.black,
    accentColor: Colors.tealAccent[700],
    textTheme: GoogleFonts.comfortaaTextTheme(),
  );



  return myTheme;
}