//@dart=2.9
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:mime_type/mime_type.dart';

Future<String> uploadData(String path, Uint8List data) async {
  print('111111111111111111');
  final storageRef = FirebaseStorage.instance.ref().child(path);
  final metadata = SettableMetadata(contentType: mime(path));
  final result = await storageRef.putData(data, metadata);
  print('----------------------------------------------------');
  return result.state == TaskState.success ? result.ref.getDownloadURL() : null;
}
