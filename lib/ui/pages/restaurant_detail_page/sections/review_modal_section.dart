import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:resto/common/styles.dart';
import 'package:resto/viewmodel/restaurant_detail_viewmodel.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class ReviewModalSection
    extends HookViewModelWidget<RestaurantDetailViewModel> {
  @override
  Widget buildViewModelWidget(context, model) {
    var nameCon = useTextEditingController();
    var reviewCon = useTextEditingController();

    return WillPopScope(
      onWillPop: () async {
        model.toogleshowReviewModal();
        return false;
      },
      child: Stack(
        children: <Widget>[
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => model.toogleshowReviewModal(),
            child: Opacity(
              child: Container(width: double.infinity, color: Colors.black),
              opacity: 0.35,
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(Gap.m),
              width: MediaQuery.of(context).size.width - Gap.xl,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Berikan Review",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      GestureDetector(
                        child: Icon(Icons.close),
                        onTap: () => model.toogleshowReviewModal(),
                      )
                    ],
                  ),
                  SizedBox(height: Gap.l),
                  TextField(
                    controller: nameCon,
                    maxLines: 1,
                    decoration: InputDecoration(
                      hintText: "Nama",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: Gap.s),
                  TextField(
                    controller: reviewCon,
                    maxLines: 4,
                    minLines: 3,
                    decoration: InputDecoration(
                      hintText: "Tulis reviewmu disini",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: secondaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: Gap.l),
                  RaisedButton(
                    onPressed: () => model.giveReview(
                      context: context,
                      name: nameCon.text,
                      review: reviewCon.text,
                    ),
                    child: model.tryingToGiveReview
                        ? SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text("Tambah Review"),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
