import 'package:flutter/material.dart';
import '../modelss/todo.dart';

class ListItem extends StatelessWidget {
  final ToDo todo;
  final onToDoChange;
  final onDeleteItem;

  const ListItem({
    super.key,
    required this.todo,
    required this.onToDoChange,
    required this.onDeleteItem,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final titleStyle = TextStyle(
      color: theme.colorScheme.onBackground,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      decoration:
          todo.isDone ? TextDecoration.lineThrough : TextDecoration.none,
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        onTap: () {
          onToDoChange(todo);
        },
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        tileColor: theme.colorScheme.surfaceVariant,
        leading: Icon(
          todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
          color: theme.colorScheme.primary,
        ),
        title: Text(
          todo.text,
          style: titleStyle,
        ),
        trailing: Container(
          padding: EdgeInsets.all(0),
          height: 35,
          width: 35,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: theme.colorScheme.error,
          ),
          child: IconButton(
            onPressed: () {
              onDeleteItem(todo.id);
            },
            icon: const Icon(Icons.delete),
            iconSize: 18,
            color: theme.colorScheme.background,
          ),
        ),
      ),
    );
  }
}
