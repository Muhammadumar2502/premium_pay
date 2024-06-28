import 'dart:io';

import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart';

class PdfHelper {
  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {

    // bool dirDownloadExists = true;
var directory;
// if (Platform.isIOS) {
//   directory = await getExternalStorageDirectory();
// } else {
//   directory = "/storage/emulated/0/Download/";

//    dirDownloadExists = await Directory(directory).exists();
//   if(dirDownloadExists){
//     directory = "/storage/emulated/0/Download/";
//   }else{
   
//     directory = "/storage/emulated/0/Downloads/";
//   }
// }
     if (Platform.isAndroid) {
       directory = await getDownloadsDirectory();
     }else if (Platform.isIOS) {
      directory = await getApplicationSupportDirectory();
     }

    final bytes = await pdf.save();

    
    final file =  File('${directory.path}/$name');
     
    // .create(recursive: true);
    if(!(await file.exists())){
     await file.create();
    }

    await file.writeAsBytes(bytes);
    print("**********");
    print(file.path);
    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;

    await OpenFile.open(url);
  }
}
