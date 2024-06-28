import 'package:premium_pay_new/export_files.dart';

class Base64Service {
  String filetoBase64(String path) {
    File imageFile = File(path);
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    print("length:${base64Image.length}");
    return base64Image;
  }

  Widget base64toFile(String data) {
    var image = base64Decode(data);
    return Image.memory(image);
  }
}
