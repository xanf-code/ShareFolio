import 'package:flutter/material.dart';
import 'package:my_app/Widget/text_span_title.dart';

class PopularCategories extends StatelessWidget {
  const PopularCategories({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 24.0,
            bottom: 12.0,
          ),
          child: TextSpanTitle(
            string1: "Popular ",
            string2: "Categories",
          ),
        ),
        Container(
          color: Colors.yellow,
          height: 250,
        ),
      ],
    );
  }
}
