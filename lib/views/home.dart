import 'package:flutter/material.dart';
import 'package:quizmaker/helper/functions.dart';
import 'package:quizmaker/services/auth.dart';
import 'package:quizmaker/services/database.dart';
import 'package:quizmaker/views/create_quiz.dart';
import 'package:quizmaker/views/play_quiz.dart';
import 'package:quizmaker/views/signin.dart';
import 'package:quizmaker/widgets/widgets.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoggedIn = false;
  AuthService authService = new AuthService();
  bool isSignedOut = false;
  DatabaseService databaseService = new DatabaseService();
  Stream quizStream;
  Widget quizList() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24.0),
      child: StreamBuilder(
        stream: quizStream,
        builder: (context, snapshot) {
          return snapshot.data == null
              ? Container()
              : ListView.builder(
                  itemCount: snapshot.data.documents.length,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return QuizTile(
                      imgUrl: snapshot.data.documents[index].data["quiz Url"],
                      title: snapshot.data.documents[index].data["quiz title"],
                      desc: snapshot
                          .data.documents[index].data["quiz description"],
                      quizId: snapshot.data.documents[index].data["quizId"],
                    );
                  },
                );
        },
      ),
    );
  }

  changeLoggedInValue() async {
    await authService.signout().then((value) {
      setState(() {
        HelperFunctions.saveUserLoggedInDetails(isLoggedIn: false);
      });
    });
  }

  @override
  void initState() {
    databaseService.getQuizData().then((value) {
      setState(() {
        quizStream = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black87),
          title: appbar(),
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () {
                  changeLoggedInValue();
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SignIn()));
                }),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CreateQuiz()));
          },
          child: Icon(Icons.add),
        ),
        body: quizList());
  }
}

class QuizTile extends StatelessWidget {
  final String imgUrl, title, desc, quizId;
  QuizTile(
      {@required this.imgUrl,
      @required this.title,
      @required this.desc,
      @required this.quizId});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => PlayQuiz(quizId)));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        width: MediaQuery.of(context).size.width - 20,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                imgUrl,
                height: 150.0,
                width: MediaQuery.of(context).size.width - 20,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 150.0,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.black26,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.w400),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    desc,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
