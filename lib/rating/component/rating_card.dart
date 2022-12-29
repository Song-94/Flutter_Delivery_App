import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/common/const/colors.dart';
import 'package:collection/collection.dart';
import 'package:flutter_delivery_app/rating/model/rating_model.dart';

class RatingCard extends StatelessWidget {
  // NetworkImage , AssetImage , CircleAvatar
  final ImageProvider avatarImage;

  // 리스트로 위젯 이미지를 보여줄 때.
  final List<Image> images;

  // 별점
  final int rating;

  // 이메일
  final String email;

  // 리뷰내용
  final String content;

  const RatingCard({
    Key? key,
    required this.avatarImage,
    required this.images,
    required this.rating,
    required this.email,
    required this.content,
  }) : super(key: key);

  factory RatingCard.fromModel({
    required RatingModel model,
  }) {

    print('rating card : ${model.imgUrls}');

    return RatingCard(
      avatarImage: NetworkImage(
        model.user.imageUrl,
      ),
      images: model.imgUrls.map((e) => Image.network(e)).toList(),
      rating: model.rating,
      email: model.user.username,
      content: model.content,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Header(
          avatarImage: avatarImage,
          email: email,
          rating: rating,
        ),
        const SizedBox(height: 8.0),
        _Body(
          content: content,
        ),
        if (images.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: SizedBox(
              height: 100,
              child: _Images(
                images: images,
              ),
            ),
          ),
      ],
    );
  }
}

class _Header extends StatelessWidget {
  final ImageProvider avatarImage;
  final String email;
  final int rating;

  const _Header({
    required this.avatarImage,
    required this.email,
    required this.rating,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12.0,
          backgroundColor: Colors.black,
          backgroundImage: avatarImage,
        ),
        const SizedBox(width: 8.0),
        Expanded(
          child: Text(
            email,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14.0,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        ...List.generate(
          5,
          (index) => Icon(
            (index < rating) ? Icons.star : Icons.star_border_outlined,
            color: PRIMARY_COLOR,
          ),
        ),
      ],
    );
  }
}

class _Body extends StatelessWidget {
  final String content;

  const _Body({
    required this.content,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Flexible 을 넣어야 줄 수가 다음 줄로 넘어 갈 수 있음.
        Flexible(
          child: Text(
            content,
            style: const TextStyle(
              color: BODY_TEXT_COLOR,
              fontSize: 14.0,
            ),
          ),
        ),
      ],
    );
  }
}

class _Images extends StatelessWidget {
  final List<Image> images;

  const _Images({
    required this.images,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: Axis.horizontal,
      children: images.mapIndexed(
        (index, e) {
          return Padding(
            padding: EdgeInsets.only(
              right: (index == images.length - 1) ? 0 : 16.0,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: e,
            ),
          );
        },
      ).toList(),
    );
  }
}
