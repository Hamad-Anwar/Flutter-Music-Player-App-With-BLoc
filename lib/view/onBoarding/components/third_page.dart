import 'package:flutter/material.dart';

import 'boarding_page.dart';

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  BoardingPage(
        text: 'Let\'s vibe togather!Create your\nown playlist and enjoy music',
        title: 'Customize Your Beast');
  }
}
