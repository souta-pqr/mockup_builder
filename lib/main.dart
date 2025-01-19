import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/editor_state.dart';
import 'views/editor_screen.dart';

void main() {
  runApp(const MockupBuilderApp());
}

class MockupBuilderApp extends StatelessWidget {
  const MockupBuilderApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EditorState(),
      child: MaterialApp(
        title: 'Webサイトモックアップビルダー',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const EditorScreen(),
      ),
    );
  }
}