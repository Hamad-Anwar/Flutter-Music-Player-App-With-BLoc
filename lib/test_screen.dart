import 'package:flutter/material.dart';
import 'package:flutter_draggable_widget/draggable_widget.dart';
import 'package:music/res/app_colors.dart';
import 'package:music/view/common_widget/soft_button.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  double val=0.3;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Flutter Draggable Widget',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: DraggableWidget(
                  widget: CircularSoftButton(
                    radius: 40,
                    padding: 0,
                    circularRadius: 10,
                    icon: Icon(
                      Icons.add,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                  initialPosition: InitialPosition.bottomRightCorner,
                  height: 80,
                  width: 80),
            ),
            Positioned.fill(
              child: DraggableWidget(
                  widget: CircularSoftButton(
                    radius: 50,
                    padding: 0,
                    icon: Icon(
                      Icons.play_arrow_rounded,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                  initialPosition: InitialPosition.center,
                  height: 100,
                  width: 100),
            ),
            Positioned.fill(
              child: DraggableWidget(
                  widget: Container(
                    height: 50,
                    width: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: backgroundColor,
                      boxShadow: [
                        BoxShadow(
                            color: shadowColor, offset: Offset(8, 6), blurRadius: 12),
                        BoxShadow(
                            color: Colors.white,
                            offset: Offset(-8, -6),
                            blurRadius: 12),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: 150,
                      height: 4,
                      child: LinearProgressIndicator(
                        value: 0.3,
                        color: Colors.blue,
                        backgroundColor: Colors.grey.withOpacity(.05),
                      ),
                    ),
                  ),
                  initialPosition: InitialPosition.topCenter,
                  height: 50,
                  width: 200),
            ),
          ],
        ));
  }
}
