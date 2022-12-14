import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/common/const/colors.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 일반적으로 위젯은 각각이 가지고 있는 최대의 크기가 있음.
    // 그래서 Column 안에 AxisAlignment 조절 하더라도,
    // 위젯 고유의 크기 때문에 안변하는 경우가 생김.
    // IntrinsicHeight : 내부에 있는 모든 위젯들이 최대 크기를 차지한 위젯만큼 크기를 차지.
    return IntrinsicHeight(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.asset(
              'asset/img/food/ddeok_bok_gi.jpg',
              width: 110,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '떡볶이',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '전통 떡볶이의 정석\n맛있습니다.',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: const TextStyle(
                    color: BODY_TEXT_COLOR,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '￦10000',
                  textAlign: TextAlign.right,
                  style: const TextStyle(
                    color: PRIMARY_COLOR,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
