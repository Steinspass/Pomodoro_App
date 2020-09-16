import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

Widget buildFabButton(IconData icon, double size, Function() onTap ){
  return GestureDetector(
      onTap: onTap,
      child: NeumorphicIcon(
        icon,
        size: size,
        style: NeumorphicStyle(
          color: Colors.tealAccent[700],
          depth: 2,
          intensity: 1,
          shape: NeumorphicShape.flat
        ),
      ),
    );
}