import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:video_app/screens/record_screen_15.dart';

import '../constants/global_variables.dart';

void showPopupMenu(BuildContext context, Offset globalPosition,
    CountDownController controller) async {
  final RenderBox overlay =
      Overlay.of(context).context.findRenderObject() as RenderBox;

  await showMenu(
    context: context,
    position: RelativeRect.fromLTRB(
      globalPosition.dx,
      globalPosition.dy - 100,
      overlay.size.width - globalPosition.dx + 30,
      overlay.size.height - globalPosition.dy,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    color: GlobalVariables.richBlack,
    constraints: BoxConstraints(maxWidth: 75, maxHeight: 200),
    items: [
      PopupMenuItem(
        child: Text(
          "15s",
          style: TextStyle(color: Colors.white),
        ),
        onTap: () {
          controller.restart(duration: 15);
          controller.pause();
        },
      ),
      PopupMenuItem(
        child: Text(
          "30s",
          style: TextStyle(color: Colors.white),
        ),
        onTap: () {
          controller.restart(duration: 30);
          controller.pause();
        },
      ),
      PopupMenuItem(
        child: Text(
          "60s",
          style: TextStyle(color: Colors.white),
        ),
        onTap: () {
          controller.restart(duration: 60);
          controller.pause();
        },
      ),
      PopupMenuItem(
        child: Text(
          "90s",
          style: TextStyle(color: Colors.white),
        ),
        onTap: () {
          controller.restart(duration: 90);
          controller.pause();
        },
      ),
    ],
  );
}
