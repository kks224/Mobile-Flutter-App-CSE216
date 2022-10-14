//class for data model:

//imports:
//import 'dart:ui';
//import 'package:flutter/cupertino.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:developer' as developer;

//import 'package:the_buzz/model/post.dart';

//String DatabasePostToJSON(DatabasePost data) => json.encode(data.PostIdea.fromJSON());

class DatabasePost {
  String? status;
  dynamic data;

  DatabasePost({
    this.status,
    this.data,
  });

  factory DatabasePost.fromJson(Map<String, dynamic> json) {
    return DatabasePost(
        status: json['status'], data: PostIdea.fromJson(json['data']));
  }
}

class Activity {
  int? likes;

  Activity({
    this.likes,
  });

  factory Activity.fromJson(Map<dynamic, dynamic> json) {
    return Activity(
      likes: json['likes'],
    );
  }
}

class PostIdea {
  final String title, body, created;
  final int post_id;
  Activity activity;

  PostIdea({
    required this.post_id,
    required this.title,
    required this.body,
    required this.created,
    required this.activity,
  });

  factory PostIdea.fromJson(Map<dynamic, dynamic> json) {
    //print('json $json');
    final postIdea = PostIdea(
        post_id: json['post_id'],
        title: json['title'],
        body: json['body'],
        created: json['created'],
        //fixed:
        activity: Activity.fromJson(json['activity']));
    return postIdea;
  }
}

Future<List<PostIdea>> fetchPostIdea() async {
  //put in heroku URL here instead:
  final response = await http
      .get(Uri.parse('https://boiling-plateau-92586.herokuapp.com/posts'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response, then parse the JSON.
    List<PostIdea> returnData;
    var res = jsonDecode(response.body);
    //print('json decode: $res');

    if (res is List) {
      //print('res list $res ');
      returnData = (res).map((x) => PostIdea.fromJson(x)).toList();
    } else if (res is Map) {
      var d = res["data"];
      //print('res map $d');
      returnData = [];
      for (var element in d) {
        returnData.add(PostIdea.fromJson(element));
      }
    } else {
      developer
          .log('ERROR: Unexpected json response type (was not a List or Map).');
      returnData = List.empty();
    }
    return returnData;
  }
  // If the server did NOT return a 200 OK response,
  else {
    // then throw an exception.
    throw Exception('Did not receive success status code from request.');
  }
}

//Creating a Post:
Future<bool> createPostIdea(String title, String body) async {
  //api URL:
  final url = Uri.parse('https://boiling-plateau-92586.herokuapp.com/posts');
  final headers = {"Content-Type": "application/json"};
  final json = '{"title":"$title", "body":"$body"}';
  //.POST route:
  final response = await http.post(url, headers: headers, body: json);
  print(response.body);
  if (response.statusCode == 200) {
    //response is ok
    return true;
  } else {
    //response NOT ok:
    return false;
  }
}

/*
We modified the current function to imitate the function that you have in your index.tsx file.
Everytime we call the function, it returns a 404 not found error.
We copied the link directly from your function,
and even when put into a browser, it returns a 404. Just to confirm that
the 404 was returned due to a function call but nothing to display, we called the posts
list again, and the likes had not changed. We have added a local change to make the likes count
change for now, but it is not working with the db bc the url is returning a 404.- FIXED 
*/

Future<bool> likeUnlikePostIdea(int postId, bool like) async {
  //api URL:
  String url;
  if (like) {
    url = 'https://boiling-plateau-92586.herokuapp.com/posts/${postId}/like';
  } else {
    url = 'https://boiling-plateau-92586.herokuapp.com/posts/${postId}/dislike';
  }
  final uri = Uri.parse(url);
  final headers = {"Content-Type": "application/json"};
  final response = await http.post(uri, headers: headers);
  print(response.body);
  if (response.statusCode == 200) {
    //response is ok
    return true;
  } else {
    //response NOT ok:
    return false;
  }
}


/*
export async function likeOrDislikePost(
  post_id: number,
  like: boolean
): Promise<boolean> {
  let endpoint = `/posts/${post_id}/`;
  if (!like) {
    endpoint += "dislike";
  } else {
    endpoint += "like";
  }
  try {
    const response = await fetch(
      `${process.env.REACT_APP_BACKEND_URL}${endpoint}`,
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
      }
    );
    if (response.status === 200) {
      return true;
    }
    return false;
  } catch (error) {
    console.error("Error liking/disliking post, refreshing anyways", error);
    return false;
  }
}
*/


//Liking a POST:
/*
Future<bool> likePostIdea(int postId, bool like) async {
  //api URL:
  String url = 'https://boiling-plateau-92586.herokuapp.com/posts/${postId}';
  if (like) {
    url += '/like';
  } else {
    url += '/dislike';
  }
  final uri = Uri.parse(url);
  final headers = {"Content-Type": "application/json"};
  final response = await http.put(uri, headers: headers);
  print(response.body);
  if (response.statusCode == 200) {
    //response is ok
    return true;
  } else {
    //response NOT ok:
    return false;
  }
}
*/

//Liking a POST:
/*Future<bool> likePostIdea(int postId, bool like) async {
  //api URL:
  String url = 'https://boiling-plateau-92586.herokuapp.com/posts/${postId}';
  if (like) {
    url += '/like';
  } else {
    url += '/dislike';
  }
  final uri = Uri.parse(url);
  final headers = {"Content-Type": "application/json"};
  final response = await http.put(uri, headers: headers);
  print(response.body);
  if (response.statusCode == 200) {
    //response is ok
    return true;
  } else {
    //response NOT ok:
    return false;
  }
}*/

