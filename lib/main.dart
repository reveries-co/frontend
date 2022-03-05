import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Color(0xFFf3f2fa),
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () {},
                color: Color(0xFF3E424B),
                icon: const Icon(Icons.search),
              )
            ],
            title: Center(
              child: Image(
                  image: AssetImage('img/mesh_logo_nobg.png'),
                height: 20,
              ),
            ),
            backgroundColor: Color(0xFFF0F3F8),
          ),
          body: Center(

          )
        )),
  );
}
