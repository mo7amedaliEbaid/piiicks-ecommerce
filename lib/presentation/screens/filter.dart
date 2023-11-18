import 'package:flutter/material.dart';
import 'package:piiicks/core/constant/colors.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 150),
          //   color: AppColors.LightGrey,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                child: Container(
                  height: 40,
                  color: AppColors.LightGrey,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Category"), Icon(Icons.add)],
                  ),
                ),
              ),
              Visibility(
                  visible: isVisible,
                  //  replacement: SizedBox.shrink(),
                  child: Container(
                    height: 100,
                    color: Colors.grey,
                    child: Column(
                      children: [
                        Text("catname"),
                        Text("catname"),
                        Text("catname"),
                        Text("catname"),
                      ],
                    ),
                  )),
              Text("hhhhhhhhhhhhhhhhhhhh")
            ],
          ),
        ),
      ),
    );
  }
}
