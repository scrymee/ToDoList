import 'package:flutter/material.dart';
//Flutterのウィジェットを使いますという宣言

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  //Widget build() return の中には最初に絶対書くもの
  Widget build(BuildContext context) {
    //buildした後は、Widgetのインスタンスを返す。
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: ToDoList(),
    );
  }
}


class ToDoList extends StatefulWidget{
  @override
  _ToDoListState createState() => _ToDoListState();
}


class _ToDoListState extends State<ToDoList>{

  List<String> listItem=[];

  var _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter += 1;
      listItem.add("楽天$_counter");
    });
  }

  void _addToDo(String value){
    setState(() {
      listItem.add(value);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ToDo List'),),
      body: _ToDoLists(listItem),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
  Widget _ToDoLists(listItem){
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            labelText: 'ToDoリスト',
            hintText: '入力して下さい',
            icon: Icon(Icons.add_box),
          ),
          autocorrect: false,
          autofocus: true,
          keyboardType: TextInputType.text,
          onSubmitted: _addToDo,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return _ToDoList(listItem, index);
            },
            itemCount: listItem.length,
          ),
        ),
      ],
    );
  }
  Widget _ToDoList(listItem, index) {
    return Dismissible(
      key: Key(listItem[index]),//選択部分を特定できるようuniqueなもの。これだと同名のToDOリストを書くとエラー
      onDismissed: (direction){
        setState((){
          listItem.removeAt(index);
        });
      },
      background: Container(color:Colors.red),
      secondaryBackground: Container(color:Colors.blue),
      child:ListTile(
        leading: Icon(Icons.mood),
        title: Text(listItem[index]),
        subtitle: Text('subtitle'),
        trailing: Icon(Icons.more_vert),
      ),
    );
  }
}



