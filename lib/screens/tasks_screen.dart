import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todoey_flutter/models/task_data.dart';
import 'package:todoey_flutter/screens/add_task_modal.dart';
import 'package:todoey_flutter/widgets/my_floating_action_button.dart';
import 'package:todoey_flutter/widgets/my_task_list.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: [0.0, 0.6],
          colors: [
            Colors.orange.shade800,
            Colors.amber.shade200,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Consumer<TaskData>(
          builder: (context, taskData, child) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80,
              ),
              GestureDetector(
                onDoubleTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        padding: EdgeInsets.fromLTRB(8, 24, 8, 4),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Icon(
                              Icons.delete_forever_rounded,
                              size: 48,
                              color: Colors.red.shade600,
                            ),
                            SizedBox(height: 24),
                            Text(
                              'Do you want to delete all tasks?',
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 24),
                            TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.orange.shade50,
                                primary: Colors.orange.shade600,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              onPressed: () {
                                taskData.resetTasks();
                                Navigator.pop(context);
                              },
                              child: Text('Yes, sure!'),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 24),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                      bottomLeft: Radius.circular(4),
                    ),
                  ),
                  child: Icon(
                    Icons.check_rounded,
                    size: 48,
                    color: Colors.orange.shade800,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text(
                  'Todoey',
                  style: GoogleFonts.poppins(
                      fontSize: 40,
                      fontWeight: FontWeight.w800,
                      color: Colors.white),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TaskList(
                          title: 'Todo',
                          tasks: taskData.availableTasks,
                          toggleTask: taskData.toggleTask,
                        ),
                        // TaskList(
                        //   title: 'Next days',
                        //   // tasks: ['Task one', 'Task two', 'Task three'],
                        //   tasks: [],
                        //   toggleTask: taskDataNotListen.toggleTask,
                        // ),
                        TaskList(
                          isDone: true,
                          title: 'Done',
                          tasks: taskData.doneTasks,
                          toggleTask: taskData.toggleTask,
                        ),
                        SizedBox(
                          height: 64,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: MyFloatingActionButton(
          onPressed: () async {
            showModalBottomSheet(
              context: context,
              builder: (context) => AddTaskModal(),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              isScrollControlled: true,
            );
          },
          color: Colors.orange.shade600,
          icon: Icons.add_rounded,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
