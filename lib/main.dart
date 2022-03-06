import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            backgroundColor: Color(0xFFf3f2fa),
            appBar: AppBar(
              leading: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(
                  backgroundImage: AssetImage('img/daniel.png'),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IconButton(
                    onPressed: () {},
                    color: Color(0xFF3E424B),
                    icon: const Icon(Icons.search),
                  ),
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
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 30.0),
                child: Column(
                  children: [
                    Text(
                      'Permanent Notes',
                      style: TextStyle(
                        fontFamily: 'Source Serif Pro',
                        fontWeight: FontWeight.w700,
                        fontSize: 40.0,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              offset: const Offset(
                                0.0,
                                4.0,
                              ),
                              blurRadius: 16.0,
                              spreadRadius: 5.0,
                            ),
                          ]),
                      padding: EdgeInsets.all(10.0),
                      margin: EdgeInsets.symmetric(
                          vertical: 30.0, horizontal: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              '#14 Liquid Modernity',
                              style: TextStyle(
                                fontFamily: 'Rubik',
                                height: 5,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0,
                              ),
                            ),
                          ),
                          Text(
                            'Very interesting way of describing how people my age see their vision of the world, and how future societies, but you won\'t be an innovator. ',
                            style: TextStyle(
                              fontFamily: 'Rubik',
                              height: 5,
                              fontSize: 10.0,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )));
  }
}