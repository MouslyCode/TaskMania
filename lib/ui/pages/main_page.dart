part of 'pages.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final List<String> entries = <String>['A', 'B', 'C'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
            itemCount: entries.length,
            itemBuilder: (BuildContext context, index) {
              return Container(
                height: 50,
                color: Colors.blue,
                child: Center(
                  child: Text('Entry ${entries[index]}'),
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
          onPressed: null),
    );
  }
}
