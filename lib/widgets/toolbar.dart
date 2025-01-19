import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/editor_state.dart';

class Toolbar extends StatelessWidget {
  const Toolbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      color: Colors.white,
      child: Column(
        children: [
          _buildToolbarItem(context, 'text', Icons.text_fields, 'テキスト'),
          _buildToolbarItem(context, 'image', Icons.image, '画像'),
          _buildToolbarItem(context, 'button', Icons.smart_button, 'ボタン'),
        ],
      ),
    );
  }

  Widget _buildToolbarItem(BuildContext context, String type, IconData icon, String label) {
    return Draggable<String>(
      data: type,
      feedback: Material(
        elevation: 4.0,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: Colors.blue.withOpacity(0.5),
          child: Icon(icon),
        ),
      ),
      child: ListTile(
        leading: Icon(icon),
        title: Text(label),
        onTap: () {
          // ドラッグ開始時の初期位置
          final editorState = context.read<EditorState>();
          editorState.addElement(
            DesignElement(
              type: type,
              position: const Offset(100, 100),
            ),
          );
        },
      ),
    );
  }
}