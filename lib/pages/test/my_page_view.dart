import 'package:flutter/material.dart';

class MyPageView extends StatefulWidget {
  const MyPageView({Key? key}) : super(key: key);

  @override
  _MyPageViewState createState() => _MyPageViewState();
}

class _MyPageViewState extends State<MyPageView> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pager"),
      ),
      body: PageView(
        controller: _pageController,
        children: [
          Container(
            color: Colors.red,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_pageController.hasClients) {
                    _pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: const Text('Next'),
              ),
            ),
          ),
          Container(
            color: Colors.blue,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_pageController.hasClients) {
                    _pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                    );
                  }
                },
                child: const Text('Previous'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
