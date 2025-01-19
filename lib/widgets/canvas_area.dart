import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/editor_state.dart';

class CanvasArea extends StatelessWidget {
  const CanvasArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<EditorState>(
      builder: (context, editorState, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            return Container(
              color: Colors.grey[200],
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  if (editorState.elements.isEmpty)
                    const Center(
                      child: Text('ここに要素をドラッグ&ドロップしてください'),
                    ),
                  DragTarget<String>(
                    builder: (context, candidateData, rejectedData) {
                      return SizedBox(
                        width: constraints.maxWidth,
                        height: constraints.maxHeight,
                        child: Stack(
                          children: [
                            ...editorState.elements.asMap().entries.map((entry) {
                              final index = entry.key;
                              final element = entry.value;
                              return Positioned(
                                left: element.position.dx,
                                top: element.position.dy,
                                child: Draggable<int>(
                                  data: index,
                                  feedback: _buildElementPreview(element.type),
                                  childWhenDragging: Opacity(
                                    opacity: 0.5,
                                    child: _buildElement(element.type),
                                  ),
                                  child: _buildElement(element.type),
                                  onDragEnd: (details) {
                                    final RenderBox renderBox = context.findRenderObject() as RenderBox;
                                    final localPosition = renderBox.globalToLocal(details.offset);
                                    editorState.updateElementPosition(index, localPosition);
                                  },
                                ),
                              );
                            }).toList(),
                          ],
                        ),
                      );
                    },
                    onAcceptWithDetails: (details) {
                      final RenderBox renderBox = context.findRenderObject() as RenderBox;
                      final localPosition = renderBox.globalToLocal(details.offset);
                      editorState.addElement(
                        DesignElement(
                          type: details.data,
                          position: localPosition,
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildElementPreview(String type) {
    return Material(
      color: Colors.transparent,
      child: Opacity(
        opacity: 0.7,
        child: _buildElement(type),
      ),
    );
  }

  Widget _buildElement(String type) {
    switch (type) {
      case 'text':
        return Container(
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            color: Colors.white,
          ),
          child: const Text('テキスト'),
        );
      case 'image':
        return Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
            color: Colors.white,
          ),
          child: const Icon(Icons.image),
        );
      case 'button':
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blue),
          ),
          child: ElevatedButton(
            onPressed: () {},
            child: const Text('ボタン'),
          ),
        );
      default:
        return Container();
    }
  }
}