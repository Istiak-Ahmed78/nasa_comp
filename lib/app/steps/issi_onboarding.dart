import 'package:flutter/material.dart';

class ISSOnboardingTasksStep extends StatefulWidget {
  @override
  _ISSOnboardingTasksStepState createState() => _ISSOnboardingTasksStepState();
}

class _ISSOnboardingTasksStepState extends State<ISSOnboardingTasksStep> {
  final List<String> tasks = [
    'Inspection: Tighten loose panel',
    'Plant Growth Check: Monitor plant module',
    'Communications: Send status to Mission Control',
  ];

  Set<int> completedTasks = Set(); // store indexes of completed tasks

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ISS Onboarding Tasks')),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final isCompleted = completedTasks.contains(index);
            return Card(
              child: ListTile(
                title: Text(
                  tasks[index],
                  style: TextStyle(
                    decoration: isCompleted ? TextDecoration.lineThrough : null,
                  ),
                ),
                trailing: ElevatedButton(
                  onPressed:
                      isCompleted
                          ? null
                          : () {
                            setState(() {
                              completedTasks.add(index);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${tasks[index]} completed!'),
                                duration: Duration(seconds: 2),
                              ),
                            );
                          },
                  child: Text(isCompleted ? 'Completed' : 'Complete'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isCompleted ? Colors.grey : Colors.blueAccent,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
