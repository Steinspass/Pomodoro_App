import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';


class BuildDrawerMenu extends StatefulWidget {
  BuildDrawerMenu({Key key}) : super(key: key);

  @override
  _BuildDrawerMenuState createState() => _BuildDrawerMenuState();
}

class _BuildDrawerMenuState extends State<BuildDrawerMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10.0,
      child: _listOfSettings(),
    );
  }

  Widget _listOfSettings() {
    return Container(
      color: Colors.grey[900],
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _headerDrawer(),
          _listTileOptions(),
          _listTileOptions(),
          _listTileOptions(),
          _listTileOptions(),
          _listTileOptions(),
          _listTileOptions(),
                  
        ],
      ),
    );
  }

  Widget _headerDrawer(){
    return DrawerHeader(
      padding: EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 10.0
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.tealAccent[100],
            Colors.tealAccent[400],
            Colors.tealAccent[700],
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
        )
      ),
      child: Center(
        child: Text(
          "Options",
          style: TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w800,
          color: Colors.white 
        ),
        ),
      ),
    );
  }

  Widget _listTileOptions() {
    return ListTile(
      title: Text(
        'Time work duration: 25',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w400,
          color: Colors.grey[100] 
        ),
      ),
      leading: NeumorphicIcon(
        Icons.chevron_left,
        style: NeumorphicStyle(
          color: Colors.tealAccent[700],
          depth: 1,
          intensity: 1,
          shape: NeumorphicShape.flat
        ),
      ),
      trailing: NeumorphicIcon(
        Icons.timer,
        style: NeumorphicStyle(
          color: Colors.tealAccent[700],
          depth: 1,
          intensity: 1,
          shape: NeumorphicShape.flat
        ),
      ),
    );
  }
}