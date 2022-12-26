import 'package:hive_flutter/hive_flutter.dart';

class Database {
  List info = [];

  late Box _myBox;

  Database(){
    _myBox = Hive.box('mybox');
    //this.info = _myBox.get("list");
  }

  void createInitialData() {
    info = [true, false, false,false];
  }

  void loadData() {
    info = _myBox.get("list");
  }

  void updateDataBase() {
    _myBox.put("list", info);
  }
}
