
import 'dart:io';
import 'package:image/image.dart';

void main() {
  // Create a blank image
  final image = Image(width: 150, height: 150);

  // Fill it with a grey color
  fill(image, color: ColorRgb8(128, 128, 128));

  // Save the image to a file
  File('assets/images/placeholder.png').writeAsBytesSync(encodePng(image));
}
