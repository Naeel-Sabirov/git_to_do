import 'package:flutter/material.dart';

import '../modelss/todo.dart';

import '../widgets/list_item.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final todos = ToDo.mocks;
  List<ToDo> _foundToDo = [];
  final _todoController = TextEditingController();

  @override
  void initState() {
    _foundToDo = todos;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    const appBarTitleStyle = TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    );

    const listTitleStyle = TextStyle(
      color: Colors.black,
      fontSize: 24,
      fontWeight: FontWeight.w600,
    );

    final addButtonStyle = TextStyle(
      color: theme.colorScheme.background,
      fontSize: 40,
      fontWeight: FontWeight.w400,
    );

    final hintStyle = TextStyle(
      color: Colors.grey,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.colorScheme.background,
        title: const Text(
          'ToDo App',
          style: appBarTitleStyle,
        ),
      ),
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
              bottom: 75,
            ),
            child: Column(
              children: [
                _searchBar(context),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(
                          top: 40,
                          bottom: 20,
                        ),
                        child: const Text(
                          'All ToDos',
                          style: listTitleStyle,
                        ),
                      ),
                      for (ToDo todo in _foundToDo)
                        ListItem(
                          todo: todo,
                          onToDoChange: _handToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceVariant,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset.zero,
                          blurRadius: 10,
                          spreadRadius: 0,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextField(
                      controller: _todoController,
                      decoration: InputDecoration(
                        hintText: 'Add new todo item',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(
                    right: 16,
                    bottom: 16,
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      _addTodoItem(_todoController.text);
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      backgroundColor: theme.colorScheme.primary,
                      minimumSize: const Size(60, 60),
                    ),
                    child: Text(
                      '+',
                      style: addButtonStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchBar(BuildContext context) {
    final theme = Theme.of(context);
    const hintStyle = TextStyle(
      color: Colors.grey,
      fontSize: 14,
      fontWeight: FontWeight.w400,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: 35,
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: theme.colorScheme.onSurfaceVariant,
            size: 25,
          ),
          prefixIconConstraints: const BoxConstraints(
            maxHeight: 35,
            minWidth: 35,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: hintStyle,
        ),
      ),
    );
  }

  void _handToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todos.removeWhere((element) => element.id == id);
    });
  }

  void _addTodoItem(String todoName) {
    setState(() {
      todos.add(ToDo(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: todoName,
      ));
    });
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todos;
    } else {
      results = todos
          .where((element) =>
              element.text.toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }
    setState(() {
      _foundToDo = results;
    });
  }
}
