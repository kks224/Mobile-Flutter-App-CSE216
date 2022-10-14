import 'package:flutter/material.dart';
import 'package:the_buzz/screens/new_home.dart';
import 'package:the_buzz/screens/postIdea.dart';

class NewPost extends StatefulWidget {
  static const String id = 'newpost';
  const NewPost({Key? key}) : super(key: key);

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  String title = "", body = "";
  //will be displayed on the screen when data from server is received:
  //String finalResponse = "";
  //final postKey = GlobalKey(<NewPostState>);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Create Post",
                style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16.0),
              ),
              const SizedBox(height: 33.0),
              TextFormField(
                onChanged: (value) {
                  title = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title for your post';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Enter Title',
                ),
              ),
              const SizedBox(height: 33.0),
              TextFormField(
                onChanged: (value) {
                  body = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter Your Idea';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  labelText: 'Enter Body',
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  const Spacer(),
                  //button:
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xff2EB9AC)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1000.0),
                        ))),
                    onPressed: () {
                      //make post:
                      //showDialog(context: context, builder: );
                      //go back to feed:
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          createPostIdea(title, body).then((value) {
                            //refreshPosts();
                            //pass in params.
                            Navigator.pop(context);
                          });
                        });
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Text(
                        "POST",
                        style: TextStyle(
                            fontSize: 14.0, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
