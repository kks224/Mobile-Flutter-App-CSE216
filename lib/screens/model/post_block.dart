import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
import 'package:the_buzz/screens/postIdea.dart';

class PostBlock extends StatefulWidget {
  PostBlock({super.key, required this.post});

  final PostIdea post;

  bool isLiked = false;

  @override
  _PostBlockState createState() => _PostBlockState();
}

class _PostBlockState extends State<PostBlock> {

  @override
  void initState() {
    super.initState();
    numOfLikes = widget.post.activity.likes!;
  }

  Icon getLikesIcon() {
    if (widget.isLiked) {
      return const Icon(CupertinoIcons.heart_fill,
          size: 16.0, color: Color(0xff2EB9AC));
    } else {
      return const Icon(CupertinoIcons.heart,
          size: 16.0, color: Color(0xff2EB9AC));
    }
  }

  int numOfLikes = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4.0, 0.0, 4.0, 14.0),
      child: Container(
        decoration: BoxDecoration(
            color: const Color(0xffE4F2F0),
            borderRadius: BorderRadius.circular(10.0)),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(22.0, 14.0, 22.0, 14.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.post.title,
                style: const TextStyle(
                    fontWeight: FontWeight.w800, fontSize: 23.0),
              ),
              const SizedBox(
                height: 8.0,
              ),
              Text(
                widget.post.body,
                style: const TextStyle(
                    fontWeight: FontWeight.w400, fontSize: 15.0),
              ),
              const SizedBox(height: 16.0),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.isLiked = !widget.isLiked;
                        // function to like post
                        if (widget.isLiked) {
                          likeUnlikePostIdea(widget.post.post_id, widget.isLiked);
                          numOfLikes += 1;
                        }
                        if (!widget.isLiked) {
                          // function to unlike post:
                          likeUnlikePostIdea(widget.post.post_id, widget.isLiked);
                          numOfLikes -= 1;
                        }
                      });
                    },
                    child: getLikesIcon(),
                  ),
                  const SizedBox(width: 5.0),
                  Text(
                    numOfLikes.toString(),
                    style: const TextStyle(
                        fontSize: 16.0, color: Color(0xff2EB9AC)),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
