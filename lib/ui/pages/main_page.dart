part of 'pages.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<String> _tasks = [];
  List<bool> _checkedTask = [false];

// Load Task
  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  // void didChangeDependencies() {
  //   const CircularProgressIndicator();
  //   super.didChangeDependencies();
  //   _loadTask();
  // }

  // Loading Data
  Future<void> _loadTask() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks = prefs.getStringList('tasks') ?? [];
      _checkedTask = List<bool>.filled(_tasks.length, true);
    });
  }

  // delete data
  Future<void> _deleteTask(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks.removeAt(index);
      _checkedTask.removeAt(index);
      prefs.setStringList('tasks', _tasks);
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Stack(
                    children: [
                      SafeArea(
                          child: Container(
                        color: Colors.white,
                      )),
                      SafeArea(
                          child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Text
                                Container(
                                  width: 120,
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Color(0xFF615BE6), width: 1.5),
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Center(
                                    child: Text(
                                      'TaskMania',
                                      style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          color: Color(0xFF615BE6),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                                // Icon
                                Icon(
                                  Icons.notifications_active_outlined,
                                  size: 30,
                                  color: Color(0xFF615BE6),
                                )
                              ],
                            ),
                          ),
                        ],
                      ))
                    ],
                  ),
                  SizedBox(
                    width: 500,
                    height: 300,
                    child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TableCalendar(
                              shouldFillViewport: true,
                              headerStyle: const HeaderStyle(
                                  titleCentered: true,
                                  formatButtonVisible: false),
                              focusedDay: DateTime.now(),
                              firstDay: DateTime.now(),
                              lastDay: DateTime.utc(2100)),
                        )),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Task List',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                        Text('See all')
                      ],
                    ),
                  ),
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
                            builder: (context) => EditTodoPage()),
                      );
                    },
                    child: Container(
                      height: 80,
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
                                      fontSize: 16,
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
                                          fontSize: 14,
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
                                  height: 23,
                                  width: 23,
                                  decoration: BoxDecoration(
                                    color: _checkedTask[index]
                                        ? Colors.transparent
                                        : const Color(0xFF615BE6),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: _checkedTask[index]
                                          ? Colors.grey
                                          : const Color(0xFF615BE6),
                                      width: 2,
                                    ),
                                  ),
                                ),
                                Icon(
                                  size: 14,
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
