import 'package:flutter/material.dart';

class CitySearchBar extends StatelessWidget {
  final Function(String) onSubmitted;

  const CitySearchBar({Key? key, required this.onSubmitted}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Enter city name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      textInputAction: TextInputAction.search,
      onSubmitted: onSubmitted,
    );
  }
}