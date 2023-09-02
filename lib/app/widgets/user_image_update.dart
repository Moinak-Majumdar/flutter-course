import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:transparent_image/transparent_image.dart';

Future<File> assetToFile(String path) async {
  final byteData = await rootBundle.load('assets/image/$path');
  final directory = await getTemporaryDirectory();
  final file =
      await File('${directory.path}/image/$path').create(recursive: true);

  await file.writeAsBytes(byteData.buffer
      .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

  return file;
}

class UserImageUpdate extends StatefulWidget {
  const UserImageUpdate(
      {super.key, required this.prevImgUrl, required this.onPickImage});

  final void Function(File img) onPickImage;
  final String prevImgUrl;

  @override
  State<UserImageUpdate> createState() => _UserImageUpdateState();
}

class _UserImageUpdateState extends State<UserImageUpdate> {
  File? newImage;
  String? prevImgUrl;

  @override
  void initState() {
    prevImgUrl = widget.prevImgUrl;
    super.initState();
  }

  void chooseImage(ImageSource source) async {
    final img = await ImagePicker().pickImage(
      source: source,
      maxWidth: 150,
      imageQuality: 50,
    );

    if (img != null) {
      widget.onPickImage(File(img.path));
      setState(() {
        if (prevImgUrl != null) {
          prevImgUrl = null;
        }
        newImage = File(img.path);
      });
    }
    return;
  }

  void removeImg(File img) {
    if (prevImgUrl != null) {
      setState(() {
        prevImgUrl = null;
      });
    }
    if (newImage != null) {
      widget.onPickImage(img);
      setState(() {
        newImage = null;
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
                  child: prevImgUrl != null
                      ? FadeInImage.memoryNetwork(
                          placeholder: kTransparentImage,
                          image: prevImgUrl!,
                          alignment: Alignment.center,
                          fit: BoxFit.cover,
                        )
                      : Image.file(
                          newImage ?? snapshot.data!,
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
                    if (newImage != null || prevImgUrl != null)
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
