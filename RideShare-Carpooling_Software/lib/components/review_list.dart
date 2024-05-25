import 'package:flutter/material.dart';

class ReviewList extends StatefulWidget {
  const ReviewList({super.key});

  @override
  State<ReviewList> createState() => _ReviewListState();
}

class _ReviewListState extends State<ReviewList> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        itemreview("name1", "this is a sample review"),
        itemreview("name2", "this is another sample review"),
        itemreview("name3", "this is a sample review"),
        itemreview("name4", "this is another sample review"),
        itemreview("name5", "this is another sample review"),
      ],
    );
  }

  itemreview(String title, String review) {
    return Container(
      width: double.infinity,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(title,
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(review,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w300))),
          ],
        ),
      ),
    );
  }
}
