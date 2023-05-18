import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:lettutor/utils/Time.dart';

import '../../../models/Feedback.dart';

class ReviewItem extends StatelessWidget {
  const ReviewItem({Key? key, required this.feedBack}) : super(key: key);
  final FeedBack feedBack;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: CircleAvatar(
            radius: 33,
            backgroundColor: Colors.brown.shade800,
            backgroundImage: NetworkImage(feedBack.firstInfo.avatar),
            // backgroundImage: NetworkImage(image),
          ),),

          Container(
              width: 280,
              margin: EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(children: [Text(
                    feedBack.firstInfo.name,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),Spacer() ,Text(TimeUtil.formatTimeAgo(DateTime.parse(feedBack.createdAt)))],),
                  RatingBar.builder(
                    itemSize: 15,
                    initialRating: feedBack.rating,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: EdgeInsets.symmetric(horizontal: 0.0),
                    itemBuilder: (context, _) =>
                        Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    child: Text(
                      feedBack.content,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      softWrap: true,
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}
