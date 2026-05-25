import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title = "TO DO LIST"});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _task = GlobalKey<FormState>();

  final TextEditingController _controller = TextEditingController();

  final List<ToDoItem> _toDoList = [];

  int get _counterList => _toDoList.where((item) => !item.isChecked).length;

  void _addList() {
    setState(() {
      _toDoList.add(ToDoItem(task: _controller.text));
      _controller.clear();
    });
  }

  void _removeItem(int index) {
    setState(() {
      _toDoList.removeAt(index);
    });
  }

  void _toggleItem(int index) {
    setState(() {
      _toDoList[index].isChecked = !_toDoList[index].isChecked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: .center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _task,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          hintText: 'Add New Task',
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty)
                            return "Digite algum trem";
                          return null;
                        },
                      ),
                    ),
                    IconButton.outlined(
                      onPressed: () {
                        if (_task.currentState!.validate()) {
                          _addList();
                        }
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: _toDoList.isNotEmpty
                    ? ListView.builder(
                        padding: EdgeInsets.all(8),
                        itemCount: _toDoList.length,
                        itemBuilder: (context, index) => ItemCard(
                          textTask: _toDoList[index].task,
                          onRemove: () => _removeItem(index),
                          isChecked: _toDoList[index].isChecked,
                          onToggle: () => _toggleItem(index),
                        ),
                      )
                    : Text('Lista Vazia'),
              ),
              Column(
                children: [
                  CounterList(counter: _counterList),
                  Divider(height: 16),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ToDoItem {
  ToDoItem({
    this.task = 'lorem impsum qualquer coisa aí',
    this.isChecked = false,
  });

  final String task;
  bool isChecked;
}

class ItemCard extends StatefulWidget {
  const ItemCard({
    super.key,
    this.textTask = 'lorem ipsum dolor sit amet',
    required this.onRemove,
    this.isChecked = false,
    required this.onToggle,
  });

  final String textTask;
  final VoidCallback onRemove;
  final VoidCallback onToggle;
  final bool isChecked;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  IconData checkBox = Icons.check_box_outline_blank;

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Row(
            children: [
              IconButton(
                onPressed: widget.onToggle,
                icon: Icon(
                  widget.isChecked
                      ? Icons.check_box_outlined
                      : Icons.check_box_outline_blank,
                ),
              ),

              widget.isChecked
                  ? Text(
                      widget.textTask,
                      style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                      ),
                    )
                  : Text(widget.textTask),
            ],
          ),

          IconButton(onPressed: widget.onRemove, icon: const Icon(Icons.close)),
        ],
      ),
    );
  }
}

class CounterList extends StatefulWidget {
  const CounterList({super.key, this.counter = 0});
  final int counter;

  @override
  State<CounterList> createState() => _CounterListState();
}

class _CounterListState extends State<CounterList> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('Your remaining To Dos: '), Text('${widget.counter}')],
    );
  }
}
