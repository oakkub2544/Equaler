import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoadingAnimationWidget.inkDrop(
      color: const Color.fromRGBO(100, 93, 83, 1),
      size: 50,
    );
  }
}
