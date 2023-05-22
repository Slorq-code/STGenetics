// ignore: unused_import
// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:bomham/Screens/burger_options_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (contet) => const BurgerOptionsScreen()));
      },
      child: Scaffold(
        body: Center(
          child: _ChefCard(),
        ),
      ),
    );
  }
}

class _ChefCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      width: 450,
      child: Column(
        children: <Widget>[
          // const Divider(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: const Text(
              "Welcome to Bom Hamburguer",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: const Text(
              "loading food information...",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
          _TarjetaImagen(),
          const SizedBox(height: 10),
          // const Divider(height: 5),
        ],
      ),
    );
  }
}

class _TarjetaImagen extends StatefulWidget {
  @override
  _TarjetaImagenState createState() => _TarjetaImagenState();
}

class _TarjetaImagenState extends State<_TarjetaImagen> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(milliseconds: 4000), () {
      Navigator.push(context,
          MaterialPageRoute(builder: (contet) => const BurgerOptionsScreen()));
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // Aquí se cancela el temporizador
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: const ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Image(
            image: AssetImage('assets/img/chefImg.jpg'),
          ),
        ),
      ),
    );
  }
}
