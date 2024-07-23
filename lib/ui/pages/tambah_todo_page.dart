part of 'pages.dart';

class TambahTodoPage extends StatefulWidget {
  final index, value;
  TambahTodoPage({this.index, this.value, super.key});

  @override
  State<TambahTodoPage> createState() => _TambahTodoPageState();
}

class _TambahTodoPageState extends State<TambahTodoPage> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  // ignore: unused_field
  List<String> _tasks = [];

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

  Future<void> _saveTask() async {
    final String task = _taskController.text;
    final String date = _dateController.text;

    if (task.isNotEmpty && date.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String> tasks = prefs.getStringList('tasks') ?? [];
      tasks.add('$task|$date');
      await prefs.setStringList('tasks', tasks);

      _taskController.clear();
      _dateController.clear();

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Success')));

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
                  'Add ',
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
            TextFormField(
              controller: _taskController,
              decoration: const InputDecoration(labelText: "Enter Task"),
            ),
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
            ElevatedButton(
                onPressed: _saveTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF615BE6),
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
