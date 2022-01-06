import 'package:flutter/material.dart';
import 'package:quizapp/data/questions_list.dart';
import 'package:quizapp/screens/result_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color mainColor = const Color(0xFF252C4A);
  Color secondColor = const Color(0xFF117EEB);

  // page controller for the page_view
  final PageController? _pageController = PageController(initialPage: 0);

  // setting game variables
  bool isPressed = false;
  Color isTrue = Colors.green;
  Color isWrong = Colors.red;
  Color btnColor = const Color(0xFF117EEB);

  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColor,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: PageView.builder(
          controller: _pageController!,
          physics: const NeverScrollableScrollPhysics(),
          onPageChanged: (page) {
            setState(() {
              isPressed = false;
            });
          },
          itemCount: questions.length,
          itemBuilder: (BuildContext context, int index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Question ${index + 1} /${questions.length}",
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 28.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.white,
                  height: 8.0,
                  thickness: 2.0,
                ),
                const SizedBox(height: 20.0),
                Text(
                  questions[index].question!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                  ),
                ),
                const SizedBox(height: 35.0),

                /// to generate a list of buttons, that will represent the
                /// answers to the questions for that let's use the for loop
                for (int i = 0; i < questions[index].answer!.length; i++)
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(bottom: 18.0),
                    child: MaterialButton(
                      shape: const StadiumBorder(),
                      color: isPressed
                          ? questions[index].answer!.entries.toList()[i].value
                              ? isTrue
                              : isWrong
                          : secondColor,
                      padding: const EdgeInsets.symmetric(vertical: 22.0),
                      onPressed: () {
                        isPressed
                            ? () {}
                            : setState(() {
                                isPressed = true;
                              });
                        if (questions[index]
                            .answer!
                            .entries
                            .toList()[i]
                            .value) {
                          score += 10;
                        }
                      },
                      child: Text(
                        questions[index].answer!.keys.toList()[i],
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton(
                      onPressed: isPressed
                          ? index + 1 == questions.length
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => ResultScreen(score),
                                    ),
                                  );
                                }
                              : () {
                                  _pageController!.nextPage(
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.linear,
                                  );
                                  setState(() {
                                    isPressed = false;
                                  });
                                }
                          : null,
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(
                          const StadiumBorder(),
                        ),
                        side: MaterialStateProperty.all(
                          const BorderSide(color: Colors.orange, width: 1.0),
                        ),
                      ),
                      child: Text(
                        index + 1 == questions.length
                            ? "See Result"
                            : "Next Question",
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
