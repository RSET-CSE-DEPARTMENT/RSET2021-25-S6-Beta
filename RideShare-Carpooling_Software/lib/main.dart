import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ride_share_test/pages/home.dart';
import 'package:ride_share_test/pages/login_page_test.dart';
import 'package:ride_share_test/services/auth.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts package

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  bool _showText = false; // Tracks if the text should be visible

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2300), // Adjust animation duration here
    );
    _loadAnimationAndNavigate();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  _loadAnimationAndNavigate() async {
    await _animationController?.forward();
    setState(() {
      _showText = true; // Show the text after animation completes
    });
    await Future.delayed(
        const Duration(seconds: 1)); // Adjust delay after animation
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WidgetTree()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Center(
              child: Lottie.asset(
                "assets/animations/bruh.json", // Replace with your Lottie file path
                controller: _animationController,
                onLoaded: (composition) {
                  _animationController?.duration = composition.duration;
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 100.0),
                child: AnimatedOpacity(
                  opacity: _showText
                      ? 1.0
                      : 0.0, // Show or hide text based on _showText
                  duration:
                      Duration(milliseconds: 500), // Duration of the animation
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 100.0),
                    child: Text(
                      'RideShare',
                      style: GoogleFonts.pacifico(
                        fontSize: 38,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 161, 21, 21),
                        shadows: [
                          const Shadow(
                            blurRadius: 10,
                            color: Color.fromARGB(
                                255, 250, 249, 249), // Set the outline color
                            offset: Offset(0,
                                0), // Offset of the outline (0,0 means centered)
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WidgetTree extends StatefulWidget {
  WidgetTree({Key? key}) : super(key: key);

  @override
  State<WidgetTree> createState() => _WidgetTreeState();
}

class _WidgetTreeState extends State<WidgetTree> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Auth().authStateChanges,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }
}


// import 'dart:async';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:ride_share_test/pages/home.dart';
// import 'package:ride_share_test/pages/login_page_test.dart';
// import 'package:ride_share_test/services/auth.dart';
// import 'package:lottie/lottie.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: SplashScreen(),
//     );
//   }
// }

// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   AnimationController? _animationController;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       vsync: this,
//       duration:
//           const Duration(milliseconds: 1500), // Adjust animation duration here
//     );
//     _loadAnimationAndNavigate();
//   }

//   @override
//   void dispose() {
//     _animationController?.dispose();
//     super.dispose();
//   }

//   _loadAnimationAndNavigate() async {
//     await _animationController?.forward();
//     await Future.delayed(
//         const Duration(seconds: 0)); // Adjust delay after animation
//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => WidgetTree()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Lottie.asset(
//           "assets/animations/bruh.json", // Replace with your Lottie file path
//           controller: _animationController,
//           onLoaded: (composition) {
//             _animationController?.duration = composition.duration;
//           },
//         ),
//       ),
//     );
//   }
// }

// class WidgetTree extends StatefulWidget {
//   WidgetTree({Key? key}) : super(key: key);

//   @override
//   State<WidgetTree> createState() => _WidgetTreeState();
// }

// class _WidgetTreeState extends State<WidgetTree> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: Auth().authStateChanges,
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return HomePage();
//         } else {
//           return LoginPage();
//         }
//       },
//     );
//   }
// }





// import 'dart:async';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:ride_share_test/pages/home.dart';
// import 'package:ride_share_test/pages/login_page_test.dart';
// import 'package:ride_share_test/services/auth.dart';
// import 'package:lottie/lottie.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: WidgetTree(),
//     );
//   }
// }

// class WidgetTree extends StatefulWidget {
//   WidgetTree({Key? key}) : super(key: key);

//   @override
//   State<WidgetTree> createState() => _WidgetTreeState();
// }

// class _WidgetTreeState extends State<WidgetTree> {
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: Auth().authStateChanges,
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return HomePage();
//           } else {
//             return LoginPage();
//           }
//         });
//   }
// }