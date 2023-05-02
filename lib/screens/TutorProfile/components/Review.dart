import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lettutor/models/Feedback.dart';
import 'package:lettutor/screens/TutorProfile/components/ReviewItem.dart';

import '../../../services/tutorService.dart';


class Review extends StatefulWidget {
  const Review({Key? key, required this.tutorId}) : super(key: key);
  final String tutorId;
  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  final ScrollController _scrollController = ScrollController();
  int perPage = 10;
  int currentPage = 1;
  List<FeedBack> originalReviewList = [];
  bool isLoad = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initReviewList(
        currentPage, perPage, widget.tutorId);
    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        loadMoreReviewList(
            currentPage, perPage, widget.tutorId);
      }
    });
  }

  void loadMoreReviewList(page, perPage, userId) async {
    var resReviewList = await TutorService.getReview(page, perPage, userId);
    setState(() {
      currentPage++;
      originalReviewList.addAll(resReviewList!);
    });
  }

  void initReviewList(page, perPage, userId) async {
    if (!isLoad) {
      var resReviewList = await TutorService.getReview(page, perPage, userId);
      setState(() {
        currentPage++;
        originalReviewList.addAll(resReviewList!);
        isLoad = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Review"),
        ),
        body: ListView.builder(
            controller: _scrollController,
            itemCount: originalReviewList.length + 1,
            itemBuilder: (BuildContext context, int index) {
              if (index < originalReviewList.length)
                return ReviewItem(
                  feedBack: originalReviewList[index],
                );
              else
                return Padding(
                    padding: EdgeInsets.symmetric(vertical: 32),
                    child: Center(child: CircularProgressIndicator()));
            }));
  }
}
