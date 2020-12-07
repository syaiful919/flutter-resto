
import 'dart:convert';

String reviewPayloadModelToJson(ReviewPayloadModel data) => json.encode(data.toJson());

class ReviewPayloadModel {
    ReviewPayloadModel({
        this.id,
        this.name,
        this.review,
    });

    String id;
    String name;
    String review;

   
    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "review": review,
    };
}
