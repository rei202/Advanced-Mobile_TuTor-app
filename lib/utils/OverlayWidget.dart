
import 'package:flutter/widgets.dart';

import '../screens/Widget/CountdownOverlay.dart';

class OverlayWidgetUtils{
  static void showCountdownOverlay(BuildContext context) {
    late OverlayEntry overlayEntry;
     overlayEntry = OverlayEntry(
      builder: (BuildContext context) => CountdownOverlay(
        duration: 60, // thời gian đếm ngược (giây)
        onFinish: () => overlayEntry.remove(),
      ),
    );
    Overlay.of(context)!.insert(overlayEntry);
  }

}

