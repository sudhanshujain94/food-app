import 'package:flutter/material.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = '/filters_screen';
  final Map<String, bool> currentFilters;
  final Function saveFilter;
  FiltersScreen(this.currentFilters, this.saveFilter);

  @override
  _FiltersScreenState createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarian = false;
  var _vegan = false;
  var _lactoseFree = false;

  Widget _buildSwitchListTile(
      {@required String title,
      @required String subtitle,
      @required bool value,
      @required Function onChanged}) {
    return SwitchListTile(
      activeColor: Theme.of(context).primaryColorDark,
      title: Text(
        title,
        style: TextStyle(fontFamily: "MavenPro", fontSize: 15),
      ),
      value: value,
      contentPadding: const EdgeInsets.all(4),
      onChanged: onChanged,
      subtitle: Text(
        subtitle,
        style: TextStyle(fontFamily: "ArchitectsDaughter", fontSize: 16),
      ),
    );
  }

  @override
  void initState() {
    _glutenFree = widget.currentFilters["gluten"];
    _lactoseFree = widget.currentFilters["lactose"];
    _vegan = widget.currentFilters["vegan"];
    _vegetarian = widget.currentFilters["vegetarian"];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Filters"),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              widget.saveFilter(
                {
                  'gluten': _glutenFree,
                  'lactose': _lactoseFree,
                  'vegan': _vegan,
                  'vegetarian': _vegetarian,
                },
              );
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Text(
              'Adjust Your meal selection',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                    title: "Gluten-Free",
                    subtitle: "Only include gluten-free meals",
                    value: _glutenFree,
                    onChanged: (value) {
                      setState(() {
                        _glutenFree = value;
                      });
                    }),
                _buildSwitchListTile(
                    title: "Lactose-Free",
                    subtitle: "Only include lactose-free meals",
                    value: _lactoseFree,
                    onChanged: (newValue) {
                      setState(() {
                        _lactoseFree = newValue;
                      });
                    }),
                _buildSwitchListTile(
                    title: "Vegetarian",
                    subtitle: "Only include vegetrian meals",
                    value: _vegetarian,
                    onChanged: (newValue) {
                      setState(() {
                        _vegetarian = newValue;
                      });
                    }),
                _buildSwitchListTile(
                    title: "Vegan",
                    subtitle: "Only include vegan meals",
                    value: _vegan,
                    onChanged: (newValue) {
                      setState(() {
                        _vegan = newValue;
                      });
                    }),
              ],
            ),
          )
        ],
      ),
    );
  }
}
