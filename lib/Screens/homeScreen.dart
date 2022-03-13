import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = "./home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final Size _screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            //(...) button
            ElevatedButton(
              onPressed: () {},
              child: const Icon(Icons.more_horiz),
              style: ButtonStyle(
                elevation: MaterialStateProperty.all(0),
                //rounding corners
                shape: MaterialStateProperty.all(
                  const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                ),
              ),
            )
          ],
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Icon(
                  Icons.group,
                ),
              ),
              Tab(
                child: Icon(
                  Icons.person,
                ),
              ),
            ],
          ),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: ((context, index) => ),
        ),
      ),
    );
  }
}
