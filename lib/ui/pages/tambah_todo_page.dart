part of 'pages.dart';

class TambahTodoPage extends StatefulWidget {
  TambahTodoPage({super.key});

  @override
  State<TambahTodoPage> createState() => _TambahTodoPageState();
}

class _TambahTodoPageState extends State<TambahTodoPage> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

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
                  decoration: InputDecoration(
                      labelText: "Enter Date",
                      suffixIcon: Icon(
                        Icons.calendar_today,
                        color: Color(0xFF615BE6),
                      )),
                ),
              ),
            ),
            SizedBox(
              height: 33,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF615BE6),
                ),
                child: Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
      ),
    );
  }
}
