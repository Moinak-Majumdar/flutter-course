import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

Future<File> assetToFile(String path) async {
  final byteData = await rootBundle.load('assets/image/$path');
  final directory = await getTemporaryDirectory();
  final file =
      await File('${directory.path}/image/$path').create(recursive: true);

  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({super.key, required this.onPickImage});

  final void Function(File img) onPickImage;
  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? userProfileImg;

  void chooseImage(ImageSource source) async {
    final img = await ImagePicker().pickImage(
      source: source,
      maxWidth: 150,
      imageQuality: 50,
    );

    if (img != null) {
      widget.onPickImage(File(img.path));
      setState(() {
        userProfileImg = File(img.path);
      });
    }
    return;
  }

  void removeImg(File img) {
    if (userProfileImg != null) {
      widget.onPickImage(img);
      setState(() {
        userProfileImg = null;
      });
    }
    return;
  }

  @override
  Widget build(context) {
    return FutureBuilder(
        future: assetToFile('defaultProfile.png'),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            if (userProfileImg == null) {
              widget.onPickImage(snapshot.data!);
            }
            return Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  height: 100,
                  width: 100,
                  clipBehavior: Clip.hardEdge,
                  child: Image.file(
                    userProfileImg ?? snapshot.data!,
                    alignment: Alignment.center,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 60),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {
                            chooseImage(ImageSource.camera);
                          },
                          icon: const Icon(Icons.camera_alt),
                          color: Theme.of(context).colorScheme.primary,
                          style: ButtonStyle(
                            iconSize: const MaterialStatePropertyAll(32),
                            backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).colorScheme.primaryContainer,
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'or',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 5),
                        IconButton(
                          onPressed: () {
                            chooseImage(ImageSource.gallery);
                          },
                          icon: const Icon(Icons.image),
                          style: ButtonStyle(
                            iconSize: const MaterialStatePropertyAll(32),
                            backgroundColor: MaterialStatePropertyAll(
                              Theme.of(context).colorScheme.primaryContainer,
                            ),
                          ),
                          color: Theme.of(context).colorScheme.primary,
                        )
                      ],
                    ),
                    if (userProfileImg != null)
                      ElevatedButton.icon(
                        onPressed: () {
                          removeImg(snapshot.data!);
                        },
                        icon: const Icon(Icons.delete),
                        label: Text(
                          'Remove',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary),
                        ),
                        style: ButtonStyle(
                          iconSize: const MaterialStatePropertyAll(24),
                          backgroundColor: MaterialStatePropertyAll(
                            Theme.of(context).colorScheme.secondaryContainer,
                          ),
                          iconColor: MaterialStatePropertyAll(
                            Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      )
                  ],
                ),
              ],
            );
          }
          return const CircularProgressIndicator();
        });
  }
}
