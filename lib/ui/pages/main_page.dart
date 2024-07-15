part of 'pages.dart';

class MainPage extends StatefulWidget {
  MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<String> entries = <String>['A', 'B', 'C'];
  List<String> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTask();
  }

  @override
  void didChangeDependencies() {
    CircularProgressIndicator();
    super.didChangeDependencies();
    _loadTask();
  }

  Future<void> _loadTask() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks = prefs.getStringList('tasks') ?? [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF615BE6),
        title: Text(
          'Todo List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
            padding: EdgeInsets.all(8),
            itemCount: _tasks.length,
            itemBuilder: (BuildContext context, index) {
              final task = _tasks[index].split('|')[0];
              final date = _tasks[index].split('|')[1];
              return Container(
                height: 50,
                color: Colors.blue,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        '$task',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text('$date')
                    ],
                  ),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) =>
                const Divider()),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xFF615BE6),
          child: Icon(
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
