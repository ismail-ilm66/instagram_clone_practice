import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram_clone_practice/firebase/firestore_methods.dart';
import 'package:instagram_clone_practice/models/user.dart';
import 'package:instagram_clone_practice/providers/user_provider.dart';
import 'package:instagram_clone_practice/utilities/colors.dart';
import 'package:instagram_clone_practice/utilities/utils.dart';
import 'package:provider/provider.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  Uint8List? _image;
  final TextEditingController _descriptionController = TextEditingController();
  bool _isLoading = false;

  _selectImage(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: const Text('Create Post'),
          children: [
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Take a Photo'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List x = await chooseImage(ImageSource.camera);
                setState(() {
                  _image = x;
                });
              },
            ),
            SimpleDialogOption(
              padding: const EdgeInsets.all(20),
              child: const Text('Choose a Photo From Gallery'),
              onPressed: () async {
                Navigator.of(context).pop();
                Uint8List x = await chooseImage(ImageSource.gallery);
                setState(() {
                  _image = x;
                });
              },
            ),
          ],
        );
      },
    );
  }

  void postImage(
    String username,
    String uid,
    String profilePicture,
  ) async {
    setState(() {
      _isLoading = true;
    });
    try {
      String result = await FirestoreMethods().uploadPost(
          _image!, _descriptionController.text, username, uid, profilePicture);
      if (result == 'Success') {
        // ignore: use_build_context_synchronously
        displaySnackBar(context, 'Picture Posted Successfully');
        nullImage();
      } else {
        // ignore: use_build_context_synchronously
        displaySnackBar(context, result);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      displaySnackBar(context, e.toString());
    }
    setState(() {
      _isLoading = false;
    });
  }

  void nullImage() {
    _image = null;
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<UserProvider>(context).getUser;

    return _image == null
        ? Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              IconButton(
                onPressed: () {
                  _selectImage(context);
                },
                icon: const Icon(Icons.upload_sharp),
              ),
              const Text(
                'Upload An Image',
                style: TextStyle(fontWeight: FontWeight.bold),
              )
            ]),
          )
        : Scaffold(
            appBar: AppBar(
              title: const Text('Post To'),
              backgroundColor: mobileBackgroundColor,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: nullImage,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    postImage(user.username, user.uid, user.profilePhoto);
                  },
                  child: const Text(
                    'Post',
                    style: TextStyle(color: blueColor, fontSize: 18),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                _isLoading
                    ? const LinearProgressIndicator()
                    : Container(
                        padding: const EdgeInsets.only(top: 0),
                      ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(user.profilePhoto),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                            hintText: 'Write Caption Here..',
                            border: InputBorder.none),
                        maxLines: 8,
                      ),
                    ),
                    SizedBox(
                      height: 45,
                      width: 45,
                      child: AspectRatio(
                        aspectRatio: 487 / 451,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(_image!),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
  }
}
