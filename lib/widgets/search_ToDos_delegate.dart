import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:session5_project/models/ToDo_model.dart';

import '../providers/ToDos_provider.dart';

class SearchToDosDelegate extends SearchDelegate {
  Widget buildSearchBar(BuildContext context) {
    return TextField(
      onChanged: (value) {
        query = value;
      },
      decoration: InputDecoration(
        labelText: "Search",
        border: OutlineInputBorder(),
      ),);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [IconButton(onPressed: () {
      query = "";
    }, icon: Icon(Icons.clear))];

  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: (){
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return buildSuggestions(context);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<ToDoModel> toDos = Provider.of<ToDosProvider>(context).searchNotes(query);
    return ListView.builder(
        itemCount: toDos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(toDos[index].title),
          );
        });


  }
}