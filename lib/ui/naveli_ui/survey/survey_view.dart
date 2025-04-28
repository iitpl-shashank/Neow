import 'package:flutter/material.dart';
import 'package:naveli_2023/widgets/common_appbar.dart';

class SymptomsView extends StatefulWidget {
  const SymptomsView({super.key});

  @override
  State<SymptomsView> createState() => _SymptomsViewState();
}

class _SymptomsViewState extends State<SymptomsView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CommonAppBar(
        title: "",
      ),
      body: Center(child: Text("Symptoms")),
    );
  }
}
