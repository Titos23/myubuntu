import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import '../components/directory.dart';

import 'pass_item.dart';
import '../api/database.dart';


class PassManager extends ChangeNotifier {

  late PassDatabase db;
  var _passItems = <PassItem>[];
  
  init1() async {
    await requestPermission(Permission.storage);
  }
  Future<List<PassItem>> getItems ()async {
    init1();
    db = PassDatabase.instance;
    db.database;
    _passItems = await db.readAll();
    return(_passItems);
  }
  
  int _selectedIndex = -1;
  bool _createNewItem = false;

  List<PassItem> get passItems => List.unmodifiable(_passItems);
  int get selectedIndex => _selectedIndex;

  PassItem? get selectedpassItem =>
      _selectedIndex != -1 ? _passItems[_selectedIndex] : null;

  bool get isCreatingNewItem => _createNewItem;

  void createNewItem() {
    init1();
    _createNewItem = true;
    notifyListeners();
  }

  void deleteItem(int index) {
    _passItems.removeAt(index);
    notifyListeners();
  }

  void passItemTapped(int index) {
    _selectedIndex = index;
    _createNewItem = false;
    notifyListeners();
  }

  void setSelectedpassItem(String id) {
    final index = passItems.indexWhere((element) => element.id == id);
    _selectedIndex = index;
    _createNewItem = false;
    notifyListeners();
  }

  void addItem(PassItem item) {
    _passItems.add(item);
    _createNewItem = false;
    notifyListeners();
  }

  void updateItem(PassItem item, int index) {
    _passItems[index] = item;
    _selectedIndex = -1;
    _createNewItem = false;
    notifyListeners();
  }

  void completeItem(int index, bool change) {
    final item = _passItems[index];
    _passItems[index] = item.copyWith(isComplete: change);
    notifyListeners();
  }
  
}
