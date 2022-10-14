import 'package:flutter/material.dart';
import 'package:the_buzz/screens/model/post_block.dart';
import 'package:the_buzz/screens/postIdea.dart';

class NewHome extends StatefulWidget {
  static const String id = 'newhome';
  const NewHome({super.key});

  @override
  State<NewHome> createState() => _NewHomeState();
}

class _NewHomeState extends State<NewHome> {
  late Future<List<PostIdea>> _future_list_post_idea;



  @override
  void initState() {
    super.initState();
    _future_list_post_idea = fetchPostIdea();
  }

  void _retry() {
    setState(() {
      refreshPosts();
    });
  }
  //refresh posts method:
    Future refreshPosts() async {
      setState(() {
        _future_list_post_idea = fetchPostIdea();
      });
    }



  @override
  Widget build(BuildContext context) {
    var fb = FutureBuilder<List<PostIdea>>(
      future: _future_list_post_idea,
      builder: (BuildContext context, AsyncSnapshot<List<PostIdea>> snapshot) {
        Widget child;

        if (snapshot.hasData) {
          // developer.log('`using` ${snapshot.data}', name: 'my.app.category');
          // create  listview to show one row per array element of json response
          child = RefreshIndicator(
            onRefresh: refreshPosts,
            child: ListView.builder(
                  //shrinkWrap: true, //expensive! consider refactoring. https://api.flutter.dev/flutter/widgets/ScrollView/shrinkWrap.html
                  padding: const EdgeInsets.all(16.0),
                  itemCount: snapshot.data!.length,
                  itemBuilder: /*1*/ (context, i) {
                    return Column(
                        children: <Widget>[
                          PostBlock(post: snapshot.data![i]),
                        ],
                      );
                  }),
          );
        } else if (snapshot.hasError) {
          // newly added
          child = Text('${snapshot.error}');
        } else {
          // awaiting snapshot data, return simple text widget
          // child = Text('Calculating answer...');
          child = const Center(child: CircularProgressIndicator()); //show a loading spinner.
        }
        return child;
      },
    );

    return fb;
  }
}
