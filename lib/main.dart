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
  int _counter = 0;

  final GlobalKey<FormState> _task = GlobalKey<FormState>();

  void _incrementCounter() {
    setState(() {
      _counter++;
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
                child:Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        decoration: const InputDecoration(
                          hintText: 'Add New Task',
                        ),
                        validator: (String? value){
                          if(value == null || value.isEmpty) return "Digite algum trem";
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
                    )
                  ],
                )
            ),

          ],
        ),
      ),

    );
  }
}
