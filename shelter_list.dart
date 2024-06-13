import 'package:flutter/material.dart';

class ShelterList extends StatelessWidget {
  final List<String> shelter;

  ShelterList({required this.shelter});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text('Shelter', style: TextStyle(fontSize: 20)),
          Expanded(
            child: ListView.builder(
              itemCount: shelter.length,
              itemBuilder: (context, index) {
                return ListTile(title: Text(shelter[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}
