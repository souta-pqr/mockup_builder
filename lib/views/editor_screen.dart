import 'package:flutter/material.dart';
import '../widgets/canvas_area.dart';
import '../widgets/toolbar.dart';

class EditorScreen extends StatelessWidget {
  const EditorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('モックアップエディタ'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // TODO: 保存機能の実装
            },
          ),
          IconButton(
            icon: const Icon(Icons.undo),
            onPressed: () {
              // TODO: 元に戻す機能の実装
            },
          ),
        ],
      ),
      body: Row(
        children: const [
          Toolbar(),
          Expanded(child: CanvasArea()),
        ],
      ),
    );
  }
}