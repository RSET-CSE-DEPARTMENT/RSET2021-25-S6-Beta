import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'type.dart';
import 'otherways.dart';

void main() => runApp(MyApps());

class MyApps extends StatefulWidget {
  @override
  AppStates createState() => AppStates();
}

class AppStates extends State<MyApps> {
  String answer1 = '';
  String answer2 = '';
  String answer3 = '';
  String answer4 = '';
  String answer5 = '';
  String answer6 = '';
  TextEditingController concernsController = TextEditingController();

  Future<void> checkSkinType(Map<String, String> selectedOptions) async {
    final url = Uri.parse('http://127.0.0.1:5000/check_skin_type');
    String jsonBody = json.encode(selectedOptions);

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonBody,
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = json.decode(response.body);
        String matchedSkinType = responseData['matched_skin_type'];
        print('Match found! Skin type: $matchedSkinType');
        // You can further process the matched skin type here
      } else {
        print('Failed to check skin type: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Remove debug banner
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/5.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 250), // Added space from the top
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0), // Adjusted horizontal padding
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start, // Adjusted alignment
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 1.0, // Adjusted container width
                                padding: EdgeInsets.all(20.0), // Added padding
                                decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 241, 234, 231).withOpacity(0.7), // Transparent white background
                                  border: Border.all(
                                    color: Colors.brown,
                                    width: 2.0,
                                  ),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Does your T-Zone feel oily throughout the day?',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Radio(
                                          value: 'A',
                                          groupValue: answer1,
                                          onChanged: (value) {
                                            setState(() {
                                              answer1 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Yes'),
                                        Radio(
                                          value: 'B',
                                          groupValue: answer1,
                                          onChanged: (value) {
                                            setState(() {
                                              answer1 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Often'),
                                        Radio(
                                          value: 'C',
                                          groupValue: answer1,
                                          onChanged: (value) {
                                            setState(() {
                                              answer1 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Rarely'),
                                        Radio(
                                          value: 'D',
                                          groupValue: answer1,
                                          onChanged: (value) {
                                            setState(() {
                                              answer1 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('No'),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Does your skin feel tight after cleansing it with water?',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Radio(
                                          value: 'A',
                                          groupValue: answer2,
                                          onChanged: (value) {
                                            setState(() {
                                              answer2 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Yes'),
                                        Radio(
                                          value: 'B',
                                          groupValue: answer2,
                                          onChanged: (value) {
                                            setState(() {
                                              answer2 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Often'),
                                        Radio(
                                          value: 'C',
                                          groupValue: answer2,
                                          onChanged: (value) {
                                            setState(() {
                                              answer2 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Rarely'),
                                        Radio(
                                          value: 'D',
                                          groupValue: answer2,
                                          onChanged: (value) {
                                            setState(() {
                                              answer2 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('No'),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'How badly does your skin react to most products?',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Radio(
                                          value: 'A',
                                          groupValue: answer4,
                                          onChanged: (value) {
                                            setState(() {
                                              answer4 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Yes'),
                                        Radio(
                                          value: 'B',
                                          groupValue: answer4,
                                          onChanged: (value) {
                                            setState(() {
                                              answer4 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Often'),
                                        Radio(
                                          value: 'C',
                                          groupValue: answer4,
                                          onChanged: (value) {
                                            setState(() {
                                              answer4 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Rarely'),
                                        Radio(
                                          value: 'D',
                                          groupValue: answer4,
                                          onChanged: (value) {
                                            setState(() {
                                              answer4 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('No'),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Do you often experience redness or stinging on your face?',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Radio(
                                          value: 'A',
                                          groupValue: answer5,
                                          onChanged: (value) {
                                            setState(() {
                                              answer5 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Yes'),
                                        Radio(
                                          value: 'B',
                                          groupValue: answer5,
                                          onChanged: (value) {
                                            setState(() {
                                              answer5 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Often'),
                                        Radio(
                                          value: 'C',
                                          groupValue: answer5,
                                          onChanged: (value) {
                                            setState(() {
                                              answer5 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Rarely'),
                                        Radio(
                                          value: 'D',
                                          groupValue: answer5,
                                          onChanged: (value) {
                                            setState(() {
                                              answer5 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('No'),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    Text(
                                      'Does your skin burn when exposed to sunlight? ',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Radio(
                                          value: 'A',
                                          groupValue: answer6,
                                          onChanged: (value) {
                                            setState(() {
                                              answer6 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Yes'),
                                        Radio(
                                          value: 'B',
                                          groupValue: answer6,
                                          onChanged: (value) {
                                            setState(() {
                                              answer6 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Often'),
                                        Radio(
                                          value: 'C',
                                          groupValue: answer6,
                                          onChanged: (value) {
                                            setState(() {
                                              answer6 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('Rarely'),
                                        Radio(
                                          value: 'D',
                                          groupValue: answer6,
                                          onChanged: (value) {
                                            setState(() {
                                              answer6 = value.toString();
                                            });
                                          },
                                        ),
                                        Text('No'),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                    // Add more questions and radio buttons as needed

                                    Text(
                                      'Additional Concerns:',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                    TextField(
                                      controller: concernsController,
                                      decoration: InputDecoration(
                                        hintText: 'Enter your concerns here',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 20),
                              Center( // Centered submit button
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Handle submit button press
                                    print('Submit button pressed');
                                    print('Answer 1: $answer1');
                                    print('Answer 2: $answer2');
                                    print('Answer 3: $answer3');
                                    print('Answer 4: $answer4');
                                    print('Answer 5: $answer5');
                                    print('Answer 6: $answer6');
                                    // Print other answers as needed
                                    print('Additional Concerns: ${concernsController.text}');
                                  },
                                  child: Text('Submit'),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
  top: 75, // Adjusted top value
  right: 30, // Adjusted right value to move the icon to the right
  child:Container(
  width: 80,
  height: 80,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Colors.brown,
  ),
  child: Builder(
    builder: (context) => ElevatedButton(
      onPressed: () {
        // Check if the OtherWays page is already on the stack before pushing
        if (!Navigator.of(context).canPop()) {
          // If not on the stack, push a new instance of OtherWays
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePageButton()),
          );
        }
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.brown.withOpacity(0.8);
            }
            return Colors.transparent;
          },
        ),
      ),
      child: Icon(
        Icons.camera_alt,
        size: 40,
        color: Colors.white,
      ),
    ),
  ),
),





),


            ],
          ),
        ),
      ),
    );
  }
}
