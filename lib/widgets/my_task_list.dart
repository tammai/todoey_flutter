import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todoey_flutter/models/task.dart';

class TaskList extends StatefulWidget {
  const TaskList({
    Key? key,
    this.isDone = false,
    required this.title,
    required this.tasks,
    required this.toggleTask,
  }) : super(key: key);

  final String title;
  final List<Task> tasks;
  final bool isDone;
  final void Function(Task) toggleTask;

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  bool _expand = false;

  @override
  void initState() {
    super.initState();
    _expand = !widget.isDone;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(4),
            onTap: () {
              if (widget.tasks.length > 0) {
                setState(() {
                  _expand = !_expand;
                });
              }
            },
            child: Padding(
              padding: EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Text(
                      widget.title.toUpperCase() +
                          (widget.tasks.length > 0
                              ? ' - ${widget.tasks.length}'
                              : ''),
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange.shade600,
                        height: 2,
                      ),
                    ),
                  ),
                  Spacer(),
                  if (widget.tasks.length > 0)
                    Icon(
                      _expand
                          ? Icons.expand_less_rounded
                          : Icons.expand_more_rounded,
                      color: Colors.grey.shade600,
                      size: 24,
                    ),
                ],
              ),
            ),
          ),
        ),
        Visibility(
          visible: _expand,
          child: Column(
            children: [
              ...widget.tasks
                  .map((e) => TaskItem(
                        name: e.name,
                        isDone: e.isDone,
                        onChanged: (value) => widget.toggleTask(e),
                      ))
                  .toList(),
              if (widget.tasks.length == 0)
                Container(
                  padding: EdgeInsets.all(4),
                  child: Text(
                    widget.isDone ? 'Take a rest.' : 'Nothing to do!',
                    style: TextStyle(color: Colors.grey.shade500, fontSize: 18),
                  ),
                ),
            ],
          ),
        ),
        SizedBox(
          height: 24,
        ),
      ],
    );
  }
}

class TaskItem extends StatelessWidget {
  const TaskItem({
    Key? key,
    required this.name,
    required this.isDone,
    required this.onChanged,
  }) : super(key: key);

  final String name;
  final bool isDone;
  final void Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(4),
              onTap: () {},
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Text(
                  name,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                    color: isDone ? Colors.grey.shade400 : Colors.grey.shade800,
                    decoration: isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          width: 28,
          height: 24,
          child: Container(
            margin: EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
                color: isDone ? Colors.grey.shade300 : Colors.white,
                border: Border.all(
                  color: isDone ? Colors.grey.shade300 : Colors.grey.shade400,
                ),
                borderRadius: BorderRadius.circular(12)),
            child: Checkbox(
              value: isDone,
              onChanged: onChanged,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              side: BorderSide.none,
              activeColor: Colors.transparent,
            ),
          ),
        ),
      ],
    );
  }
}
