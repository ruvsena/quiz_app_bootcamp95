import 'package:flutter/material.dart';
import 'package:quiz_app/answer.dart';

class carpma extends StatefulWidget {
  @override
  _carpmaState createState() => _carpmaState();
}

class _carpmaState extends State<carpma>{
  List<Icon> _scoreTracker=[];
  int _questionIndex = 0 ;
  int _totalScore = 0;
  bool answerWasSelected=false;
  bool endOfQuiz=false;
  bool correctAnswerSelected = false;

  void _questionAnswered(bool answerScore){
    setState(() {
      answerWasSelected=true;
      if(answerScore){
        _totalScore++;
        correctAnswerSelected =true;
      }


      if(_questionIndex +1 ==_questions.length){
        endOfQuiz=true;
      }
    });
  }

  void _nextQuestion() {
    setState((){
      _questionIndex++;
      answerWasSelected =false;
      correctAnswerSelected=false;
    });
    if(_questionIndex >=_questions.length){_resetQuiz();  }
  }

  void _resetQuiz() {
    setState((){
      _questionIndex=0;
      _totalScore=0;
      _scoreTracker=[];
      endOfQuiz=false;
    });
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Column(

          children:[
            SizedBox(height: 30.0),
            Image.asset(
              "img/anasayfa_resmi.png",
              width:150,
              height:200,
            ),
            SizedBox(height: 20.0),
            Container(
              width: double.infinity,
              height: 130.0,
              margin: EdgeInsets.only(bottom: 10.0,left: 30.0,right: 30.0),
              padding: EdgeInsets.symmetric(horizontal: 50.0,vertical:20.0),
              decoration: BoxDecoration(
                color: Color(0xFFBF78BB),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Center(
                child: Text(
                  _questions[_questionIndex]['question'],
                  textAlign:TextAlign.center,
                  style: TextStyle(
                    fontSize: 50.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ...(_questions[_questionIndex]['answers']
            as List<Map<String, Object>>)
                .map(
                  (answer) => Answer(
                answerText: answer['answerText'],
                answerColor: answerWasSelected
                    ? answer['score']
                    ? Colors.green
                    : Colors.red
                    : Color(0xFFA3B0FA),
                answerTap: () {
                  if (answerWasSelected) {return;}
                  _questionAnswered(answer['score']);
                },
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary:Color(0xFF2F6D2F) ,
                //minimumSize: Size(double.infinity,40.0),
                padding: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
              ),
              onPressed: () {
                if(!answerWasSelected){
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text('Lütfe bir sonraki soruya geçmek için bir sayı seçin.'),
                  ));
                  return;

                }
                else if(endOfQuiz){
                  Navigator.pop(context);
                }
                _nextQuestion();
              },
              child: Text(endOfQuiz ? 'Anasayfaya Dön' : 'Sonraki Soru'),
            ),
            SizedBox(height: 20.0),
            if (answerWasSelected && !endOfQuiz)
              Container(
                height: 70,
                width: double.infinity,
                margin: EdgeInsets.only(bottom: 10.0,left: 30.0,right: 30.0),
                padding: EdgeInsets.symmetric(horizontal: 50.0,vertical:20.0),

                color: correctAnswerSelected ? Colors.green : Colors.red,
                child: Center(
                  child: Text(
                    correctAnswerSelected
                        ? 'Harika'
                        : 'malesef yanlış',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

            if (endOfQuiz)
              Container(
                height: 70,
                width: double.infinity,
                color: Colors.deepPurpleAccent,
                margin: EdgeInsets.only(bottom: 10.0,left: 30.0,right: 30.0),
                padding: EdgeInsets.symmetric(horizontal: 50.0,vertical:20.0),

                child: Center(
                  child: Text(
                    'Harika puanın: $_totalScore/6',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
final _questions=const[
  {
    'question' : '3 x 2 = ?',
    'answers':[
      {'answerText': '9','score': false},
      {'answerText': '6','score': true},
      {'answerText': '7','score': false},
    ],
  },
  {
    'question' : '2 x 4 = ?',
    'answers':[
      {'answerText': '8','score': true},
      {'answerText': '9','score': false},
      {'answerText': '6','score': false},
    ],
  },
  {
    'question' : '6 x 2 = ?',
    'answers':[
      {'answerText': '10','score': false},
      {'answerText': '8','score': false},
      {'answerText': '12','score': true},
    ],
  },
  {
    'question' : '5 x 2 = ?',
    'answers':[
      {'answerText': '10','score': true},
      {'answerText': '9','score': false},
      {'answerText': '12','score': false},
    ],
  },
  {
    'question' : '6 x 3 = ?',
    'answers':[
      {'answerText': '12','score': false},
      {'answerText': '14','score': false},
      {'answerText': '18','score': true},
    ],
  },
  {
    'question' : '8 x 2 = ?',
    'answers':[
      {'answerText': '12','score': false},
      {'answerText': '16','score': true},
      {'answerText': '18','score': false},
    ],
  },
];