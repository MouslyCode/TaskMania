part of 'pages.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<String> entries = <String>['A', 'B', 'C'];
  List<String> _tasks = [];
  List<bool> _checkedTask = [false];
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  @override
  void didChangeDependencies() {
    const CircularProgressIndicator();
    super.didChangeDependencies();
    _loadTask();
  }

  Future<void> _loadTask() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks = prefs.getStringList('tasks') ?? [];
      _checkedTask = List<bool>.filled(_tasks.length, false);
    });
  }

  Future<void> _deleteTask(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks.removeAt(index);
      _checkedTask.removeAt(index);
      prefs.setStringList('tasks', _tasks);
    });
  }

  void checked() {
    setState(() {
      isChecked = !isChecked;
    });
  }

  void toggleChecked(int index) {
    setState(() {
      _checkedTask[index] = !_checkedTask[index];
      // if (_checkedTask[index]) {
      //   _deleteTask(index);
      // }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Task ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF615BE6),
              ),
            ),
            Text(
              'Mania',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                    child: Text(
                      'Calendar',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  )
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, index) {
                  if (index >= _tasks.length) return null;
                  final task = _tasks[index].split('|')[0];
                  final date = _tasks[index].split('|')[1];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const EditTodoPage()),
                      );
                    },
                    child: Container(
                      height: 95,
                      decoration: const BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  '$task',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      color: const Color(0xFF615BE6),
                                      borderRadius: BorderRadius.circular(16)),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 3, horizontal: 10),
                                    child: Text(
                                      '$date',
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            GestureDetector(
                              onTap: () => toggleChecked(index),
                              child:
                                  Stack(alignment: Alignment.center, children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    color: _checkedTask[index]
                                        ? Colors.transparent
                                        : Color(0xFF615BE6),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: _checkedTask[index]
                                          ? Colors.grey
                                          : Color(0xFF615BE6),
                                      width: 2,
                                    ),
                                  ),
                                ),
                                Icon(
                                  size: 20,
                                  Icons.check,
                                  color: _checkedTask[index]
                                      ? Colors.grey
                                      : Colors.white,
                                )
                              ]),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF615BE6),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => TambahTodoPage()),
            );
          }),
    );
  }
}
