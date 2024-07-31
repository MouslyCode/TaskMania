part of 'pages.dart';

class EditTodoPage extends StatefulWidget {
  final int index;
  final Map<String, String> value;
  EditTodoPage({required this.index, required this.value, super.key});

  @override
  State<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends State<EditTodoPage> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  List<String> _tasks = [];

  @override
  void initState() {
    super.initState();
    _taskController.text = widget.value['tasks'] ?? '';
    _dateController.text = widget.value['date'] ?? '';
  }

// Date Selector logic
  Future<void> _selectDate(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2024),
        lastDate: DateTime(2200));
    if (picked != null && picked != selectedDate)
      setState(() {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
  }

// Saving Task
  Future<void> _saveTask() async {
    final String task = _taskController.text;
    final String date = _dateController.text;

    if (task.isNotEmpty && date.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> tasks = prefs.getStringList('tasks') ?? [];
      tasks[widget.index] = '$task|$date';
      await prefs.setStringList('tasks', tasks);

      _taskController.clear();
      _dateController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Task Updated Successfully')));

      setState(() {
        _tasks = tasks;
      });
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (context) => MainPage()),
        (Route<dynamic> route) => false,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please Enter both Task and Date')));
    }
  }

  Future<void> _deleteTask() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> tasks = prefs.getStringList('tasks') ?? [];
    tasks.removeAt(widget.index);
    await prefs.setStringList('tasks', tasks);

    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Deleted')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 43),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Edit ',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF615BE6),
                  ),
                ),
                Text(
                  'Task',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 36,
            ),
            // Input Task
            TextFormField(
              controller: _taskController,
              decoration: const InputDecoration(labelText: "Enter Task"),
            ),
            // Date Selector
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _dateController,
                  style: const TextStyle(
                      color: Color(0xFF615BE6), fontWeight: FontWeight.w500),
                  decoration: const InputDecoration(
                      labelText: "Enter Date",
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: Color(0xFF615BE6),
                      )),
                ),
              ),
            ),
            const SizedBox(
              height: 33,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: _saveTask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF615BE6),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    )),
                ElevatedButton(
                    onPressed: _deleteTask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                      'Delete',
                      style: TextStyle(color: Colors.white),
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
