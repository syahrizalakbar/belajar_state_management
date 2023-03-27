import 'package:belajar_state_management/pages/setstate/setstate_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Belajar State Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Belajar State Management"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: ((context) => SetStatePage())));
              },
              child: const Text("Set State"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Provider"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text("BLoC"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text("Cubit"),
            ),
          ],
        ),
      ),
    );
  }
}
