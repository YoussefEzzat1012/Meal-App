import 'package:flutter/material.dart';
import './main_drawer.dart';

class FiltterScreen extends StatefulWidget {
  static const routeName = '/settings';
  final Function saveFilters;
  final Map<String, bool> currentFilters;
  FiltterScreen(this.currentFilters ,this.saveFilters);

  @override
  State<FiltterScreen> createState() => _FiltterScreenState();
}

class _FiltterScreenState extends State<FiltterScreen> {
  var _glutenFree = false;
  var _vegetarin = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'] as bool;
    _lactoseFree = widget.currentFilters['lactose'] as bool;
    _vegan = widget.currentFilters['vegan'] as bool;
    _vegetarin = widget.currentFilters['vegetarian'] as bool;
    super.initState();
  }

  Widget _buildSwitchListTile(String title, String describtion,
      bool currentValue, Function(bool) ubdateValue) {
    return SwitchListTile(
      value: currentValue,
      title: Text(title),
      subtitle: Text(describtion),
      onChanged: ubdateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FilterScreen'),
        actions: [
          IconButton(onPressed: () {
            Map<String, bool> updateFilters = {
              'gluten':_glutenFree,
              'lactose': _lactoseFree,
              'vegan': _vegan,
              'vegetarian': _vegetarin
            };
            widget.saveFilters(updateFilters);
          }, icon: Icon(Icons.save)),
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile('Glutten-free', 'Only include Gluteen-free meals', _glutenFree, (newValue){
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),

                 _buildSwitchListTile('Lactose-free', 'Only include Lactose-free meals', _lactoseFree, (newValue){
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),

                _buildSwitchListTile('Vegetarin-free', 'Only include Vegetarin-free meals', _vegetarin, (newValue){
                  setState(() {
                    _vegetarin = newValue;
                  });
                }),

                _buildSwitchListTile('Vegan-free', 'Only include Vegan-free meals', _vegan, (newValue){
                  setState(() {
                    _vegan = newValue;
                  });
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
