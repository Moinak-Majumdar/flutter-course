import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageInput extends StatefulWidget {
  ImageInput({required this.onSelectImage}) : super(key: imgReset);

  final void Function(File f) onSelectImage;
  static final imgReset = GlobalKey<ImageInputState>();

  @override
  State<ImageInput> createState() {
    return ImageInputState();
  }
}

class ImageInputState extends State<ImageInput> {
  File? _selectedImage;
  void _pickPicture(String mode) async {
    final ip = ImagePicker();
    XFile? pikedImage;
    if (mode == 'take') {
      pikedImage =
          await ip.pickImage(source: ImageSource.camera, maxWidth: 600);
    }
    if (mode == 'upload') {
      pikedImage =
          await ip.pickImage(source: ImageSource.gallery, maxWidth: 600);
    }
    if (pikedImage == null) {
      return;
    }
    setState(() {
      _selectedImage = File(pikedImage!.path);
    });
    widget.onSelectImage(_selectedImage!);
  }

  void hardReset() {
    setState(() {
      _selectedImage = null;
    });
  }

  @override
  Widget build(context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 16),
      height: 250,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.secondary.withOpacity(.5),
            Theme.of(context).colorScheme.onSurface.withOpacity(.2)
          ],
        ),
      ),
      child: _selectedImage == null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton.icon(
                  onPressed: () {
                    _pickPicture('take');
                  },
                  icon: const Icon(Icons.camera_alt),
                  label: const Text('Take picture'),
                ),
                const Text(
                  '/',
                  style: TextStyle(fontSize: 32),
                ),
                TextButton.icon(
                  onPressed: () {
                    _pickPicture('upload');
                  },
                  icon: const Icon(Icons.upload),
                  label: const Text('Choose picture'),
                ),
              ],
            )
          : Stack(
              children: [
                Image.file(
                  _selectedImage!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.black54,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            _pickPicture('take');
                          },
                          icon: const Icon(Icons.camera_enhance),
                          label: const Text('Retake'),
                        ),
                        const Text(
                          '/',
                          style: TextStyle(fontSize: 32),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            _pickPicture('upload');
                          },
                          icon: const Icon(Icons.upload_file),
                          label: const Text('Reupload'),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
