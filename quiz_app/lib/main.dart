import 'package:flutter/material.dart';
import 'package:quizapp/questions.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  List<Widget> scorekeeper=[];

  //Part to insert questions
  List<Questions> questions=[
    Questions(q:"Is Putin the President of America?",a:false),
    Questions(q:"Is China the factory of the world?",a:true),
    Questions(q:"Is Brazil a part of G-20 summit?",a:true),
    Questions(q:"Does Google make Iphones?",a:false),
    Questions(q:"Are humans known as homo-sapiens?",a:true),
    Questions(q:"Is India the largest country in the world?",a:false),
    Questions(q:"Does Elephants make supersonic whistles?",a:false),
    Questions(q:"Is Blue Whale the largest living creature on Earth?",a:true),
    Questions(q:"Are Foxes omnivorous?",a:false),
    Questions(q:"Is Pakistan a part of SAARC?",a:true),
  ];

  //part to track indices
  int tracker=0;

  //marks updater
  int acheived=0;
  int total=10;

  void add_to_score(int f)
  {
    //got it correct
    if (f==1) {
      scorekeeper.add(
        Icon(
          Icons.check,
          color: Colors.green,
        ),);
      acheived+=1;
    }
    else {
      scorekeeper.add(Icon(
        Icons.close,
        color: Colors.red,
      ),);
    }
  }

  void change_qs()
  {
    if(tracker==questions.length-1)
      {
        Alert(
          context: context,
          title: "Quiz finished..",
          desc: "You have scored $acheived out of $total",
          buttons: [
            DialogButton(
              color:Colors.red,
              child: Text(
                "RESET",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              onPressed: () => Navigator.pop(context),
              width: 120,
            )
          ],
        ).show();

        //re-initialize the tracker
        tracker=0;
        //re-initialize the score-keeper
        scorekeeper.clear();
        //re-initialize the score
        acheived=0;
      }
    else
      {
        tracker+=1;
      }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                questions[tracker].text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                setState(() {
                  bool get_state=questions[tracker].ans;
                  if (get_state==true)
                    add_to_score(1);
                  else
                    add_to_score(0);
                  change_qs();
                });
              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                setState(() {
                  bool get_state=questions[tracker].ans;
                  if (get_state==false)
                    add_to_score(1);
                  else
                    add_to_score(0);
                  change_qs();
                });
              },
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        )
      ],
    );
  }
}

