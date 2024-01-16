
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_camera/flutter_camera.dart';
import 'package:video_player/video_player.dart';

class VideoUploadPage extends StatefulWidget {
  const VideoUploadPage({super.key});

  @override
  State<VideoUploadPage> createState() => _VideoUploadPageState();
}

class _VideoUploadPageState extends State<VideoUploadPage> {
  XFile? _recordedVideo;
  VideoPlayerController? _videoPlayerController;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    // Request camera and storage permissions here
  }

  @override
  Widget build(BuildContext context) {
    return FlutterCamera(
      color: Colors.amber,
      onImageCaptured: (value) {
        // Handle image capture (not used in this example)
      },
      onVideoRecorded: (value) async {
        setState(() {
          _recordedVideo = value;
        });

        await _uploadVideoToFirebase(); // Upload video after recording

        print('Recorded video path: ${_recordedVideo?.path}');

        final videoFile = File(_recordedVideo!.path);
        _videoPlayerController = VideoPlayerController.file(videoFile);
        await _videoPlayerController!.initialize();

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: VideoPlayer(_videoPlayerController!),
          ),
        );
      },
    );
  }

   _uploadVideoToFirebase() async {
    if (_recordedVideo != null) {
      try {
        final fileName = 'video_${DateTime.now()}.mp4';
        final reference = _storage.ref().child('videos').child(fileName);
        final uploadTask = reference.putFile(File(_recordedVideo!.path));

        final snapshot = await uploadTask.whenComplete(() {});
        final downloadUrl = await snapshot.ref.getDownloadURL();

        print('Video uploaded successfully: $downloadUrl');
        // Handle successful upload (e.g., display a success message, store the URL)
      } on FirebaseException catch (e) {
        print('Error uploading video: ${e.message}');
        // Handle upload errors
      }
    } else {
      print('No video to upload');
    }
  }

  @override
  void dispose() {
    _videoPlayerController?.dispose();
    super.dispose();
  }
}
