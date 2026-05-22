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
                        // TODO: Add task logic
                      }
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
            ),

            ItemCard(),
          ],
        ),
      ),
    );
  }
}

class ItemCard extends StatefulWidget {
  const ItemCard({super.key, this.textTask = 'lorem ipsum dolor sit amet'});

  final String textTask;

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

          IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
        ],
      ),
    );
  }
}
