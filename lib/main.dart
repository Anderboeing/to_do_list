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

  List<String> _toDoList = [];

  void _addList() {
    setState(() {
      _toDoList.add(_controller.text);
      _controller.clear();
    });
  }

  void _removeItem(int index) {
    setState(() {
      _toDoList.removeAt(index);
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
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
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
                        textTask: _toDoList[index].toString(),
                        onRemove: () => _removeItem(index),
                      ),
                    )
                  : Text('Lista Vazia'),
            ),
            CounterList(),
          ],
        ),
      ),
    );
  }
}

class ItemCard extends StatefulWidget {
  const ItemCard({
    super.key,
    this.textTask = 'lorem ipsum dolor sit amet',
    required this.onRemove,
  });

  final String textTask;
  final VoidCallback onRemove;

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  IconData checkBox = Icons.check_box_outline_blank;

  void checkTask() {
    setState(() {
      if (checkBox == Icons.check_box_outlined) {
        checkBox = Icons.check_box_outline_blank;
      } else {
        checkBox = Icons.check_box_outlined;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Row(
            children: [
              IconButton(onPressed: checkTask, icon: Icon(checkBox)),

              checkBox == Icons.check_box_outlined
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
      children: [Text('Your remaining To Dos: '), Text('${widget.counter}')],
    );
  }
}
