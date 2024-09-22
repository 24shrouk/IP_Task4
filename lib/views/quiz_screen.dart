import 'package:flutter/material.dart';
import 'package:task4/views/result_screen.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  static const List<Map<String, Object>> _questions = [
    {
      'question': 'What does "OOP" stand for in programming?',
      'answers': [
        {'text': 'Object-Oriented Programming', 'isCorrect': true},
        {'text': 'Objective-Oriented Programming', 'isCorrect': false},
        {'text': 'Object Operating Program', 'isCorrect': false},
        {'text': 'Operations on Programs', 'isCorrect': false},
      ],
    },
    {
      'question': 'What is the time complexity of binary search?',
      'answers': [
        {'text': 'O(n)', 'isCorrect': false},
        {'text': 'O(log n)', 'isCorrect': true},
        {'text': 'O(n²)', 'isCorrect': false},
        {'text': 'O(1)', 'isCorrect': false},
      ],
    },
    {
      'question': 'Who developed Flutter?',
      'answers': [
        {'text': 'Facebook', 'isCorrect': false},
        {'text': 'Apple', 'isCorrect': false},
        {'text': 'Google', 'isCorrect': true},
        {'text': 'Microsoft', 'isCorrect': false},
      ],
    },
    {
      'question': 'What is the most popular programming language?',
      'answers': [
        {'text': 'Java', 'isCorrect': false},
        {'text': 'Python', 'isCorrect': true},
        {'text': 'C#', 'isCorrect': false},
        {'text': 'Ruby', 'isCorrect': false},
      ],
    },
  ];

  int _questionIndex = 0;
  String? _selectedAnswer;
  bool _isAnswered = false;
  int _score = 0;

  void _nextQuestion() {
    setState(() {
      _isAnswered = false;
      _selectedAnswer = null;
      if (_questionIndex < _questions.length - 1) {
        _questionIndex++;
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ResultScreen(score: _score)),
        );
      }
    });
  }

  void _submitAnswer() {
    setState(() {
      _isAnswered = true;
      if (_selectedAnswer != null) {
        final isCorrect = (_questions[_questionIndex]['answers']
                    as List<Map<String, Object>>)
                .firstWhere(
                    (answer) => answer['text'] == _selectedAnswer)['isCorrect']
            as bool;
        if (isCorrect) {
          _score++;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_questionIndex];
    final answerOptions =
        currentQuestion['answers'] as List<Map<String, Object>>;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'Quiz App',
          style: TextStyle(color: Color(0xff00ADB5)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              currentQuestion['question'] as String,
              style: const TextStyle(fontSize: 24, color: Colors.white),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ...answerOptions.map((answer) {
              // Check if this is the correct answer or not
              final isCorrect = answer['isCorrect'] as bool;
              final isSelected = answer['text'] == _selectedAnswer;

              return RadioListTile<String>(
                activeColor: Colors.white,
                value: answer['text'] as String,
                groupValue: _selectedAnswer,
                title: Text(
                  answer['text'] as String,
                  style: TextStyle(
                    color: _isAnswered
                        ? isCorrect
                            ? Colors.green
                            : isSelected
                                ? Colors.red
                                : Colors.white
                        : Colors.white,
                  ),
                ),
                onChanged: _isAnswered
                    ? null
                    : (value) {
                        setState(() {
                          _selectedAnswer = value;
                        });
                      },
                secondary: _isAnswered
                    ? Icon(
                        isCorrect ? Icons.check_circle : Icons.cancel,
                        color: isCorrect ? Colors.green : Colors.red,
                      )
                    : null,
              );
            }),
            //.toList(),
            const SizedBox(height: 20),
            ElevatedButton(
              style: const ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Color(0xffFFFFFF))),
              onPressed: _isAnswered
                  ? _nextQuestion
                  : _selectedAnswer == null
                      ? null
                      : _submitAnswer,
              child: Text(
                _isAnswered ? 'Next' : 'Submit',
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
