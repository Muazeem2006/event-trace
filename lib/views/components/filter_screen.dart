// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, prefer_const_literals_to_create_immutables, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({Key? key}) : super(key: key);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  RangeValues _currentRangeValues = const RangeValues(20, 120);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text('Filter'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FilterCategorySection(),
              SizedBox(height: 24),
              FilterOptionSection(
                title: 'Time & Date',
                options: ['Today', 'Tomorrow', 'This week'],
              ),
              SizedBox(height: 16),
              FilterLocationSection(),
              SizedBox(height: 16),
              Text(
                'Select price range',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('\$${_currentRangeValues.start.round().toString()}'),
                  Text('\$${_currentRangeValues.end.round().toString()}'),
                ],
              ),
              RangeSlider(
                values: _currentRangeValues,
                min: 0,
                max: 200,
                divisions: 40,
                labels: RangeLabels(
                  '\$${_currentRangeValues.start.round().toString()}',
                  '\$${_currentRangeValues.end.round().toString()}',
                ),
                onChanged: (RangeValues values) {
                  setState(() {
                    _currentRangeValues = values;
                  });
                },
              ),
              SizedBox(height: 24),
              Row(
                children: <Widget>[
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _currentRangeValues = const RangeValues(
                              20, 120); // Default range values
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: BorderSide(color: Colors.blue),
                      ),
                      child: Text('RESET'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Apply filter logic
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('APPLY'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class FilterCategorySection extends StatelessWidget {
  // Dummy data for categories
  final List<String> categories = ['Sports', 'Music', 'Art', 'Food', 'More'];

   FilterCategorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.blue[200],
                  child: Icon(Icons.directions_run),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(categories[index]),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FilterOptionSection extends StatelessWidget {
  final String title;
  final List<String> options;

  FilterOptionSection({super.key, required this.title, required this.options});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Wrap(
          spacing: 8,
          children: options.map((String option) {
            return ChoiceChip(
              label: Text(option),
              selected: false,
              onSelected: (bool selected) {},
            );
          }).toList(),
        ),
      ],
    );
  }
}

class FilterLocationSection extends StatelessWidget {
  const FilterLocationSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Location',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        ListTile(
          title: Text('New York, USA'),
          trailing: Icon(Icons.keyboard_arrow_right),
          onTap: () {
            // Implement location picker
          },
        ),
      ],
    );
  }
}
