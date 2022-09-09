import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pucopoint_manager/pages/pucopointList.dart';
import 'package:pucopoint_manager/pages/shopkeeper.dart';
import 'package:pucopoint_manager/widgets/verticalSpacing.dart';
import 'package:pucopoint_manager/widgets/wave.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wave/config.dart';

class LoginComponent extends StatefulWidget {
  const LoginComponent({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<LoginComponent> createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Config animationConfig = CustomConfig(
    gradients: [
      [Colors.red, Color(0xEEF44336)],
      [Colors.red[800]!, Color(0x77E57373)],
      [Colors.orange, Color(0x66FF9800)],
      [Colors.yellow, Color(0x55FFEB3B)]
    ],
    durations: [35000, 19440, 10800, 6000],
    heightPercentages: [0.20, 0.23, 0.25, 0.30],
    gradientBegin: Alignment.bottomLeft,
    gradientEnd: Alignment.topRight,
  );
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            waveWithLabel(),
            form(),
            verticalSpacing(165),
            loginButton(),
          ],
        ),
      ),
    );
  }

  Widget waveWithLabel() {
    return Stack(
      children: [
        waveAnimation(
          backgroundColor: Colors.purpleAccent,
          height: MediaQuery.of(context).size.height / 4,
          context: context,
          config: animationConfig,
        ),
      ],
    );
  }

  Widget form() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Image.asset(
            'assets/pucoreadslogo.png',
            height: 50,
            width: 200,
          ),
          verticalSpacing(50),
          emailInput(),
          verticalSpacing(20),
          passwordInput(),
          verticalSpacing(30),
          invisibleText()
        ],
      ),
    );
  }

  Widget emailInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: emailController,
        decoration: InputDecoration(
          labelText: 'Email',
          labelStyle: const TextStyle(
            fontSize: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        style: const TextStyle(
          fontSize: 20,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Please enter your email';
          }
          if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            return 'Please enter a valid email';
          }
          return null;
        },
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget passwordInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: TextFormField(
        controller: passwordController,
        decoration: InputDecoration(
          labelText: 'Password',
          labelStyle: const TextStyle(
            fontSize: 20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
        obscureText: !_passwordVisible,
        style: const TextStyle(
          fontSize: 20,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Password is required';
          }
          return null;
        },
        keyboardType: TextInputType.text,
      ),
    );
  }

  Widget invisibleText() {
    return _isLoading ? CircularProgressIndicator() : Text("");
  }

  Widget loginButton() {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 70,
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Continue',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        setState(() {
          _isLoading = true;
        });

        // Get.to(Shopkeeper());
        if (_formKey.currentState!.validate()) {
          // Get.changeTheme(ThemeData.dark());

          signIn();
          // ScaffoldMessenger.of(context).showSnackBar(
          //   const SnackBar(
          //     content: Text('Logged in successfully'),
          //   ),
          // );
        } else {
          setState(() {
            _isLoading = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Please fill all fields'),
            ),
          );
        }
      },
    );
  }

  Future signIn() async {
    if (emailController.text.trim() != "" &&
        passwordController.text.trim() != "") {
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: emailController.text.trim(),
                password: passwordController.text.trim())
            .whenComplete(() => {
                  setState(() {
                    _isLoading = false;
                  })
                });
      } on FirebaseAuthException catch (e) {
        
            ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('username or password is incorrect'),
            ),
          );
            
            
        
      }
    } else {
      setState(() {
        _isLoading = false;
      });
      const SnackBar(
        content: Text('Please fill all fields correctly'),
      );
    }
  }
}
