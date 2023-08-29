import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:session5_project/models/ToDo_model.dart';
import '../providers/ToDos_provider.dart';
import '../widgets/search_ToDos_delegate.dart';


class ToDosScreen extends StatelessWidget {
  const ToDosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider=Provider.of<ToDosProvider>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          String title="";
          showDialog(context: context,
              builder: (context)=>AlertDialog(
                title: Text("Warning"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      onChanged: (value){
                        title = value;
                      },
                      decoration: InputDecoration(
                        labelText: "Enter title",
                        border: OutlineInputBorder(),
                      ),
                    ),

                  ],
                ),
                actions: [
                  ElevatedButton(
                    child: Text("Add"),
                    onPressed: (){
                      provider.addToDo(
                          ToDoModel(title: title)
                      );
                      Navigator.pop(context);
                    },
                  ),
                  ElevatedButton(
                    child: Text("Cancel"),
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                ],
              )
          );

        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('ToDo List'),
        actions: [
          IconButton(
            onPressed: (){
              showSearch(context: context, delegate: SearchToDosDelegate());
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Consumer<ToDosProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.toDos.length,
            itemBuilder: (context, index) {
              return Dismissible(
                key: ValueKey(provider.toDos[index]),
                onDismissed: (direction){
                  provider.deleteToDOs(index);
                },
                child: InkWell(     onTap:(){
                   String updatedTitle=provider.toDos[index].title;
                  showDialog(context: context,
                      builder: (context)=>AlertDialog(
                        title: Text("Warning"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(

                              controller: TextEditingController(text: provider.toDos[index].title),
                              onChanged: (value){
                                updatedTitle = value;
                              },
                              decoration: InputDecoration(

                                labelText: "Enter title",
                                border: OutlineInputBorder(),
                              ),
                            ),
                            // SizedBox(height: 10,),

                          ],
                        ),
                        actions: [
                          ElevatedButton(
                            child: Text("Save"),
                            onPressed: (){
                              provider.updateToDo(index, ToDoModel(title: updatedTitle)
                              );
                                  Navigator.pop(context);
                            },
                          ),
                          ElevatedButton(
                            child: Text("Cancel"),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      )
                  );

                },
                  child: Container(
                    height: 60,
                    margin: EdgeInsets.all(15),
                    child: CheckboxListTile(
                     // value: false,
                    value:   provider.toDos[index].sign,
                      onChanged:(value){
                        provider.changeValue(value as bool,index);
                      },



                      title: Text(provider.toDos[index].title),

                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}