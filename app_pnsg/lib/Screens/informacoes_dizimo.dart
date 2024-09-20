import 'package:flutter/material.dart';


class InformacoesDizimo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InformacoesDizimoState();
  }
}
class InformacoesDizimoState extends State<InformacoesDizimo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
            child: Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const SizedBox(height: 50),
                const Text('Dízimo:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,)),
        ]
    ),
    ),
      ),
    );
  }

}