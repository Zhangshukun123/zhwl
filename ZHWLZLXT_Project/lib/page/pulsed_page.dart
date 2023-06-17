import 'package:flutter/cupertino.dart';

class PulsedPage extends StatefulWidget {
  const PulsedPage({Key? key}) : super(key: key);

  @override
  State<PulsedPage> createState() => _PulsedPageState();
}

class _PulsedPageState extends State<PulsedPage> {
  @override
  Widget build(BuildContext context) {
    return const Text("PulsedPage");
  }
}
