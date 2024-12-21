import 'package:flutter/material.dart';

class CustomFloatingMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final RenderBox button = context.findRenderObject() as RenderBox;
        final RenderBox overlay =
            Overlay.of(context).context.findRenderObject() as RenderBox;

        final Offset position = button.localToGlobal(
          Offset.zero,
          ancestor: overlay,
        );

        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(
            position.dx,
            position.dy - button.size.height,
            position.dx + button.size.width,
            position.dy + button.size.height,
          ),
          items: [
            PopupMenuItem(value: 'image', child: Text('Изображение')),
            PopupMenuItem(value: 'drawing', child: Text('Рисунок')),
            PopupMenuItem(value: 'list', child: Text('Список')),
            PopupMenuItem(value: 'text', child: Text('Текст')),
          ],
        ).then((value) {
          if (value != null) {
            print('Вы выбрали: $value');
          }
        });
      },
      child: Icon(Icons.add),
    );
  }
}
