import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_to_day/provider/data_provider.dart';
import 'package:provider/provider.dart';

import '../../app_theme.dart';

class ImageSwiperScreen extends StatelessWidget {
  static const id = '/ImageSwiperScreen';
  ImageSwiperScreen._({
    required DataProvider dataProvider,
  }) : _dataProvider = dataProvider;

  static Widget setProviderRoute() {
    return Consumer<DataProvider>(
      builder: (_, dataProvider, __) => ImageSwiperScreen._(
        dataProvider: dataProvider,
      ),
    );
  }

  final DataProvider _dataProvider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100.h,
          width: MediaQuery.of(context).size.width,
          child: Row(
            children: [
              IconButton(onPressed: () {}, icon: Icon(Icons.clear)),
            ],
          ),
        ),
        Expanded(
          child: Swiper(
            itemCount: _dataProvider.handleSwipeItemCount(),
            itemBuilder: _dataProvider.handleSwipeItemBuilder,
            scrollDirection: Axis.horizontal,
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                color: AppTheme.grey800,
                activeColor: Colors.white,
                size: 5,
                activeSize: 7,
              ),
            ),
            loop: false,
          ),
        ),
      ],
    );
  }
}
