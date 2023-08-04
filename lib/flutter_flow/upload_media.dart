//@dart=2.9
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime_type/mime_type.dart';

import '../auth/auth_util.dart';

const allowedFormats = {'image/png', 'image/jpeg', 'video/mp4', 'image/gif'};

class SelectedMedia {
  const SelectedMedia(this.storagePath, this.bytes);
  final String storagePath;
  final Uint8List bytes;
}

Future<SelectedMedia> selectMedia({
  double maxWidth,
  double maxHeight,
  bool isVideo = false,
  bool fromCamera = false,
}) async {
  final picker = ImagePicker();
  final source = fromCamera ? ImageSource.camera : ImageSource.gallery;
  final pickedMediaFuture = isVideo
      ? picker.getVideo(source: source)
      : picker.getImage(
          maxWidth: maxWidth, maxHeight: maxHeight, source: source);
  final pickedMedia = await pickedMediaFuture;
  final mediaBytes = await pickedMedia?.readAsBytes();
  if (mediaBytes == null) {
    return null;
  }
  final path = storagePath(currentUserUid, pickedMedia.path, isVideo);
  return SelectedMedia(path, mediaBytes);
}

bool validateFileFormat(String filePath, BuildContext context) {
  print(filePath);
  print(allowedFormats);
  if (allowedFormats.contains(mime(filePath))) {
    return true;
  }
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(
      content: Text('Invalid file format: ${mime(filePath)}'),
    ));
  return true;
}

String storagePath(String uid, String filePath, bool isVideo) {
  final timestamp = DateTime.now().microsecondsSinceEpoch;
  // Workaround fixed by https://github.com/flutter/plugins/pull/3685
  // (not yet in stable).
  final ext = isVideo ? 'mp4' : filePath.split('.').last;
  return 'users/$uid/uploads/$timestamp.$ext';
}

void showUploadMessage(BuildContext context, String message,
    {bool showLoading = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        duration: showLoading?Duration(minutes: 30):Duration(seconds: 4),
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (showLoading)
              Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: CircularProgressIndicator(),
              ),
            Text(message,style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20
            ),),
          ],
        ),
      ),
    );
}
Future<bool> alert(BuildContext context, String message,
    ) async {
  bool result=  await showDialog(
      context: context,
      builder: (context) => AlertDialog(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.0)
    ),
    title: Text('Are you sure ?'),
    content: Text(message),
    actions: <Widget>[
      TextButton(
        onPressed: (){
          Navigator.of(context, rootNavigator: true).pop(false);
          },
        child: Text(
            'No',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black
            )
        ),
      ),
      TextButton(
        onPressed: (){
          Navigator.of(context, rootNavigator: true).pop(true);
          },
        child: Text(
            'Yes',
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.red
            )
        ),
      )
    ],
  )
  );
  return result;
}
