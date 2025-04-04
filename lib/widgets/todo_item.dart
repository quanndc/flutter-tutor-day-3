import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoItem extends StatelessWidget {
  const TodoItem({
    super.key,
    required this.title,
    required this.subtitle,
    required this.isChecked,
    required this.checkDone,
    required this.removeTodo
  });

  final String title;
  final String subtitle;
  final bool isChecked;
  final Function checkDone;
  final Function(BuildContext) removeTodo;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      child: Slidable(
        key: const ValueKey(0),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          dragDismissible: true,
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              onPressed: (context){
                removeTodo(context);
              },
              backgroundColor: Colors.red,
              icon: Icons.delete,
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(
                  red: 0,
                  green: 0,
                  blue: 0,
                  alpha: 0.1,
                ),
                blurRadius: 4,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
          ),
          child: ListTile(
            title: Text(title),
            subtitle: Text(subtitle),
            leading: Checkbox(
                value: isChecked,
                onChanged: (value) {
                  checkDone();
                },
            ),
          ),
        ),
      ),
    );
  }
}
