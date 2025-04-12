import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hub/StartScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'DataOperations.dart';
import 'MainScreen.dart';


class LoginPage extends StatefulWidget {

  final bool isDark;

  const LoginPage({super.key, required this.isDark});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  late String _email;
  late String _password;
  late String _name;
  late String _lastname;
  late String _dadname;
  late String _number;

  final FirebaseFirestore _fStore = FirebaseFirestore.instance;

  late bool _isDark;

  @override
  void initState() {
    _isDark = widget.isDark;
    super.initState();
  }

  Future _getNetworkData() async{
    var userID = FirebaseAuth.instance.currentUser?.uid;
    _fStore.collection("users").doc(userID).get().then((DocumentSnapshot docSnapshot) async {
      if (docSnapshot.exists){
        try {

          _email = _emailController.text;
          _password = _passwordController.text;
          _name = await docSnapshot.get("name")!;
          _lastname = await docSnapshot.get("lastname")!;
          _dadname = await docSnapshot.get("dadname")!;
          _number = await docSnapshot.get("number")!;

          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("email", _email);
          await prefs.setString("password", _password);
          await prefs.setString("name", _name);
          await prefs.setString("lastname", _lastname);
          await prefs.setString("dadname", _dadname);
          await prefs.setString("number", _number);

        } catch (e) {
          throw Exception;
        }

      }
    });
  }

  bool _isShowed = false;

  void _loginCheck() async {


    _password = _passwordController.text;
    _email = _emailController.text;

    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _email,
          password: _password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Fluttertoast.showToast(msg: "Такого пользователя нет");
      } else if (e.code == 'wrong-password') {
        Fluttertoast.showToast(msg: "Введен неправильный пароль");
      } else {
        Fluttertoast.showToast(msg: "Проверьте данные");
      }

    }
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) async {
      if (user != null) {

        await _getNetworkData().whenComplete(() => Navigator.pushReplacement(context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => MainActivity(isDark: _isDark),
            transitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
          ),));

      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: GetTheme().lightTheme,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            titleSpacing: 0,
            backgroundColor: Colors.black,
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.only(bottom: 20),
          children: [

            Container(
              height: 380,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/logoEnter.png"),fit: BoxFit.fitHeight),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const AutoSizeText("Вход", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 30)),

                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    decoration: const BoxDecoration(
                      boxShadow: [BoxShadow(blurRadius: 15.2, offset: Offset.zero, color: Color(0x40000000))],
                    ),
                    child: TextField(
                      autofillHints: const [AutofillHints.email],
                      onTapOutside: (point) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Электронная почта",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
                        floatingLabelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
                        hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Color(0xFFB3B3B3)),
                        hintText: "enteryouremail@gmail.com",
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 35),
                    decoration: const BoxDecoration(
                      boxShadow: [BoxShadow(blurRadius: 15.2, offset: Offset.zero, color: Color(0x40000000))],
                    ),
                    child: TextField(
                      autofillHints: const [AutofillHints.password],
                      onTapOutside: (point) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !_isShowed,
                      decoration: InputDecoration(
                        labelText: "Пароль",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
                        floatingLabelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
                        hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Color(0xFFB3B3B3)),
                        hintText: "verystrongpassword",
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isShowed = !_isShowed;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [

                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: const Color(0xFF17354D),
                            value: _isShowed,
                            onChanged: (value) {
                              setState(() {
                                _isShowed = value!;
                              });
                            },
                          ),

                          const Expanded(
                            child: Text("Показать пароль", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600, fontSize: 14),),
                          )

                        ],
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 25, bottom: 40),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(_passwordController.text.length < 6 || _emailController.text.length <5 ? const Color(0xFFE0E0E1) : Colors.black),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 15, horizontal: 50)),
                      ),
                      onPressed: _passwordController.text.length < 6 || _emailController.text.length <5 ? null : () async {
                        _loginCheck();
                      },
                      child: AutoSizeText("Войти", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _passwordController.text.length < 6 || _emailController.text.length <5 ? const Color(0xFF7B7B7B) : Colors.white),),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterPage(isDark: _isDark,)));
                    },
                    child: const Center(
                      child: FittedBox(
                        alignment: Alignment.center,
                        fit: BoxFit.scaleDown,
                        child: Row(
                          children: [
                            AutoSizeText("Нет аккаунта? ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14),),
                            AutoSizeText("Зарегистрироваться", style: TextStyle(color: Color(0xFF17354D), fontWeight: FontWeight.bold, fontSize: 14),),
                          ],
                        ),
                      ),
                    ),
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

class RegisterPage extends StatefulWidget {

  final bool isDark;

  const RegisterPage({super.key, required this.isDark});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _dadnameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  late String _email;
  late String _password;
  late String _name;
  late String _lastname;
  late String _dadname;
  late String _number;

  late bool _isDark;

  @override
  void initState() {
    _isDark = widget.isDark;
    super.initState();
  }

  void _registerCheck() async{

    await FirebaseAuth.instance.signOut();

    _email = _emailController.text;
    _password = _passwordController.text;
    _name = _nameController.text;
    _lastname = _lastnameController.text;
    _dadname = _dadnameController.text;
    _number = _numberController.text;

    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Fluttertoast.showToast(msg: "Вы ввели слабый пароль");
      } else if (e.code == 'email-already-in-use') {
        Fluttertoast.showToast(msg: "Такая почта уже занята");
      }else {
        Fluttertoast.showToast(msg: "Проверьте данные");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Ошибка! Попробуйте позже");
    }

    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) async {
      if (user != null) {

        var userID = FirebaseAuth.instance.currentUser?.uid;

        Map<String, dynamic> map = {};
        map.addAll({
          "id" : userID,
          "email" : _email,
          "name" : _name,
          "lastname" : _lastname,
          "dadname" : _dadname,
          "number" : _number,
        });

        await SendToFireMap(map, "users");

        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString("email", _email);
        await prefs.setString("password", _password);
        await prefs.setString("name", _name);
        await prefs.setString("lastname", _lastname);
        await prefs.setString("dadname", _dadname);
        await prefs.setString("number", _number);

        Navigator.pushReplacement(context,
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => StartPage(isDark: _isDark),
            transitionDuration: const Duration(milliseconds: 400),
            transitionsBuilder: (_, a, __, c) => FadeTransition(opacity: a, child: c),
          ),);
      }
    });

  }

  bool _checkForms() {

    if (
            _emailController.text.length >=5 &&
                _emailController.text.contains("@") &&
                _emailController.text.contains(".") &&
            _passwordController.text.length >=6 &&
            _nameController.text.length >=2 &&
            _lastnameController.text.length >=2 &&
            _numberController.text.length >=10
    ){
      return true;
    } else {
      return false;
    }
  }

  bool _isShowed = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: GetTheme().lightTheme,
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            titleSpacing: 0,
            backgroundColor: Colors.black,
          ),
        ),
        body: ListView(
          padding: const EdgeInsets.only(bottom: 20),
          children: [

            Container(
              height: 380,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(image: AssetImage("assets/images/logoEnter.png"),fit: BoxFit.fitHeight),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 35),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const AutoSizeText("Регистрация", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w900, fontSize: 30)),

                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    decoration: const BoxDecoration(
                      boxShadow: [BoxShadow(blurRadius: 15.2, offset: Offset.zero, color: Color(0x40000000))],
                    ),
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.name],
                      onTapOutside: (point) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Имя",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
                        floatingLabelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
                        hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Color(0xFFB3B3B3)),
                        hintText: "Геннадий",
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 35),
                    decoration: const BoxDecoration(
                      boxShadow: [BoxShadow(blurRadius: 15.2, offset: Offset.zero, color: Color(0x40000000))],
                    ),
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.familyName],
                      onTapOutside: (point) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                      controller: _lastnameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Фамилия",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
                        floatingLabelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
                        hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Color(0xFFB3B3B3)),
                        hintText: "Гонков",
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 35),
                    decoration: const BoxDecoration(
                      boxShadow: [BoxShadow(blurRadius: 15.2, offset: Offset.zero, color: Color(0x40000000))],
                    ),
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.middleName],
                      onTapOutside: (point) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                      controller: _dadnameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: "Отчество",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
                        floatingLabelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
                        hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Color(0xFFB3B3B3)),
                        hintText: "Артемьевич",
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 35),
                    decoration: const BoxDecoration(
                      boxShadow: [BoxShadow(blurRadius: 15.2, offset: Offset.zero, color: Color(0x40000000))],
                    ),
                    child: TextField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.telephoneNumber],
                      onTapOutside: (point) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                      controller: _numberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Номер телефона",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
                        floatingLabelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
                        hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Color(0xFFB3B3B3)),
                        hintText: "79223084650",
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 35),
                    decoration: const BoxDecoration(
                      boxShadow: [BoxShadow(blurRadius: 15.2, offset: Offset.zero, color: Color(0x40000000))],
                    ),
                    child: TextField(
                      textInputAction: TextInputAction.next,
                      autofillHints: const [AutofillHints.email],
                      onTapOutside: (point) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Электронная почта",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
                        floatingLabelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
                        hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Color(0xFFB3B3B3)),
                        hintText: "enteryouremail@gmail.com",
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 35),
                    decoration: const BoxDecoration(
                      boxShadow: [BoxShadow(blurRadius: 15.2, offset: Offset.zero, color: Color(0x40000000))],
                    ),
                    child: TextField(
                      textInputAction: TextInputAction.done,
                      autofillHints: const [AutofillHints.newPassword],
                      onTapOutside: (point) {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      style: const TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
                      controller: _passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !_isShowed,
                      decoration: InputDecoration(
                        labelText: "Пароль",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
                        floatingLabelStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700,color: Colors.black),
                        hintStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Color(0xFFB3B3B3)),
                        hintText: "verystrongpassword",
                        contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                        fillColor: Colors.white,
                        filled: true,
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _isShowed = !_isShowed;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [

                          Checkbox(
                            checkColor: Colors.white,
                            activeColor: const Color(0xFF17354D),
                            value: _isShowed,
                            onChanged: (value) {
                              setState(() {
                                _isShowed = value!;
                              });
                            },
                          ),

                          const Expanded(
                            child: Text("Показать пароль", style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600, fontSize: 14),),
                          )

                        ],
                      ),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.only(top: 25, bottom: 40),
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(_checkForms() == false ? const Color(0xFFE0E0E1) : Colors.black),
                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                        padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 15, horizontal: 50)),
                      ),
                      onPressed: _checkForms() == false ? null : () {
                        TextInput.finishAutofillContext();
                        _registerCheck();
                      },
                      child: AutoSizeText("Создать аккаунт", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _checkForms() == false ? const Color(0xFF7B7B7B) : Colors.white),),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(isDark: _isDark,)));
                    },
                    child: const Center(
                      child: FittedBox(
                        alignment: Alignment.center,
                        fit: BoxFit.scaleDown,
                        child: Row(
                          children: [
                            AutoSizeText("Есть аккаунт? ", style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600, fontSize: 14),),
                            AutoSizeText("Войти", style: TextStyle(color: Color(0xFF17354D), fontWeight: FontWeight.bold, fontSize: 14),),
                          ],
                        ),
                      ),
                    ),
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
