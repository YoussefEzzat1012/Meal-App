import 'package:flutter/material.dart';
import 'filtter_screen.dart';
class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget buildListTile(String title, IconData icon, VoidCallback tabhandeler) {
    return ListTile(
      leading: Icon(icon, size: 26, ),
      title: Text(title, style: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold
      ),),
      onTap: tabhandeler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).colorScheme.secondary,
            child: Text('Drawer!', style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w900,
              color: Theme.of(context).primaryColor
            ),),
          ),
          SizedBox(height: 20,),
          buildListTile('Meals', Icons.restaurant, (){
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('Settings', Icons.settings, () {
              Navigator.of(context).pushReplacementNamed(FiltterScreen.routeName);
          }),
        ],
      ),
    );
  }
}