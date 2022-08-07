import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<Offset> offset;
  late Animation<double> sizeAnimation;
  int currentState = 0;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: Duration(seconds: 1));
    offset = Tween<Offset>(begin:  Offset(0.8, 1.0), end: Offset.zero).animate((controller));

    controller.addListener(() => setState((){}));

    sizeAnimation = Tween<double>(begin: 0, end: 1).animate((CurvedAnimation(parent: controller, curve: Curves.bounceOut)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title: Text('Pokemon Game'),
        centerTitle: true,
        backgroundColor: Colors.yellow,
    ),
      body: Center(
        child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(duration: Duration(seconds: 3),
              transform: Transform.translate(offset: Offset(0, up == true ? -100 :0),
              ).transform,
              child: Container(
                child: Image.asset('assets/img/pokemon.png',),
              ),
          ),
          AnimatedPositioned(duration: Duration(seconds: 3),
              child: Image.asset('assets/img/stone.png',
                scale: 2,)),
          Positioned(child: ElevatedButton(
              onPressed:() {
                if (currentState == 0) {
                  controller.forward();
                  currentState = 1;
                } else {
                  controller.reverse();
                  currentState = 0;
                }
              },
              child: const Text('Jump!')
          )
          ),
        ],
    ),
      ))
    );
  }
}
