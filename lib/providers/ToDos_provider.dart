import 'package:flutter/widgets.dart';

import '../models/ToDo_model.dart';


class ToDosProvider extends ChangeNotifier{
  List<ToDoModel> _toDos = [
    ToDoModel(title: 'ToDo 1'),
    ToDoModel(title: 'ToDo 2'),
    ToDoModel(title: 'ToDo 3'),
    ToDoModel(title: 'ToDo 4'),
    ToDoModel(title: 'ToDo 5'),
    ToDoModel(title: 'ToDo 6'),

  ];
  void addToDo(ToDoModel toDo){
    _toDos.add(toDo);
    notifyListeners();
  }
  List<ToDoModel> get toDos => _toDos;
  void deleteToDOs(int index){
    _toDos.removeAt(index);
    notifyListeners();
  }
  void updateToDo(int index,ToDoModel toDo){
    _toDos[index] = toDo;
    notifyListeners();
  }
  void changeValue(bool value,int index){
    _toDos[index].sign=value  ;
    notifyListeners();
  }
  List<ToDoModel> searchNotes(String query){
    return _toDos.where((element) =>
    element.title.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }

}