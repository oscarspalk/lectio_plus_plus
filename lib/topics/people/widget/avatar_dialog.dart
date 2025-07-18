import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AvatarDialog extends StatelessWidget {
  const AvatarDialog({super.key, required this.image});
  final ImageProvider image;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width * 0.8;
    print(width);
    return Dialog(
        child: SizedBox(
            width: width,
            height: width,
            child: Image(width: width, height: width, image: image)));
  }
}
