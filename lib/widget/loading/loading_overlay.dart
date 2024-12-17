import 'package:flutter/material.dart';
import 'loading_controller.dart';

class LoadingOverlay {
  LoadingOverlay._shareInstance();
  static final LoadingOverlay _shared = LoadingOverlay._shareInstance();
  factory LoadingOverlay.instance() => _shared;

  LoadingScreenController? _controller;

  void show({
    required BuildContext context,
  }) {
    _controller = showOverlay(context: context);
  }

  void hide() {
    _controller?.close();
    _controller = null;
  }

  LoadingScreenController? showOverlay({
    required BuildContext context
  }) {
    final state = Overlay.of(context);

    final overlay = OverlayEntry(
      builder: (context) {
        return Material(
          color: Colors.black.withAlpha(150),
          child: Center(
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(15),
              child: const CircularProgressIndicator()
            ),
          ),
        );
      },
    );

    state.insert(overlay);

    return LoadingScreenController(
      close: () {
        overlay.remove();
        return true;
      },
    );
  }
}
