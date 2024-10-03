import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {


  @override
  Widget build(BuildContext context) {
    final _searchController = TextEditingController();
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            SearchBar(
              controller: _searchController,
              constraints: const BoxConstraints(maxHeight: 50, minHeight: 50),
              hintText: 'Search Here..',

            )
          ],
        ),
      ),
    ));
  }
}
