import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app/model/question.dart';
import 'package:quiz_app/components/question_data.dart';

class QuizzApp extends StatefulWidget {
  const QuizzApp({super.key});

  @override
  State<QuizzApp> createState() => _QuizzAppState();
}

class _QuizzAppState extends State<QuizzApp> {
  List<Icon> scoreKeeper = [];
  QuestionData questionData = QuestionData();

  showIcons(bool userPickedAnswer){
    setState(() {
    if(questionData.isFinished() == true){

      showDialog(context: context, builder: (context){
        return AlertDialog(
          title: Text("Finished!!"),
          content: Text("Quizz has been endded",style: TextStyle(fontSize: 18),),
          actions: [
            RawMaterialButton(
              child: Text("Ok",style: TextStyle(fontSize: 18),),
                onPressed: (){
              Navigator.of(context).pop();
            })
          ],
        );
      });
      questionData.resetQuestionNumber();
      scoreKeeper = [];

    }else{
      bool correctAnswer = questionData.getAnswerText();
      if(correctAnswer == userPickedAnswer){
        scoreKeeper.add(const Icon(Icons.check,color: Colors.green,));
      }else{
        scoreKeeper.add(const Icon(Icons.close,color: Colors.red,));
      }
        questionData.nextQuestion();
    }});


  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                flex: 5,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                   questionData.getQuestionText(),
                    style: TextStyle(color: Colors.white, fontSize: 24),
                    textAlign: TextAlign.center,
                  ),
                ))),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: RawMaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    fillColor: Colors.green,
                    child: Text(
                      "True",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      showIcons(true);
                    }),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: RawMaterialButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    fillColor: Colors.red,
                    child: Text(
                      "False",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () {
                      showIcons(false);

                    }),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                children: scoreKeeper,
              ),
            ),
          ],
        ),
      ),
    );

  }
}
