import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:my_to_day/constants/constant_strings.dart';
import 'package:my_to_day/model/data/diary_data.dart';

import '../app_theme.dart';
import 'date_helper.dart';

class ModalHelper {
  static Future<void> openEditBottomModal({
    required BuildContext context,
    required Function() onSharePressed,
    required Function() onEditPressed,
  }) async {
    await showModalBottomSheet(
        context: context,
        backgroundColor: AppTheme.textSecondary2Color,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        builder: (BuildContext context) {
          return SizedBox(
            height: 70.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: onEditPressed,
                  iconSize: 20.h,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 40.w,
                ),
                IconButton(
                  onPressed: onSharePressed,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  iconSize: 20.h,
                  icon: const Icon(
                    Icons.share,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          );
        });
  }

  static Future<void> openDiaryDetailModal({
    required BuildContext context,
    required DiaryData? diaryData,
    required Function() onOptionPressed,
    required int imageItemCount,
    required Widget Function(BuildContext, int) imageItemBuilder,
  }) async {
    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return DraggableScrollableSheet(
            minChildSize: 0.9999,
            initialChildSize: 1,
            builder: (context, scrollController) => StatefulBuilder(
                builder: (BuildContext context, StateSetter modalSetState) {
              return Container(
                color: Colors.black,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: AppBar().preferredSize.height,
                  ),
                  child: ListView(
                    controller: scrollController,
                    children: [
                      Stack(
                        children: [
                          diaryData?.cameraImage != null ||
                                  diaryData?.pickerImages != null
                              ? Container(
                                  height: 300.h,
                                  child: Swiper(
                                    itemCount: imageItemCount,
                                    itemBuilder: imageItemBuilder,
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
                                )
                              : Container(),
                          Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: Navigator.of(context).pop,
                              icon: const Icon(
                                Icons.cancel,
                                color: AppTheme.grey600,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  DateHelper.convertDateMonth(diaryData!.time),
                                  style: AppTheme.button_small.copyWith(
                                    color: AppTheme.grey400,
                                    fontSize: 11.sp,
                                  ),
                                ),
                                IconButton(
                                  onPressed: onOptionPressed,
                                  icon: const Icon(
                                    Icons.more_horiz_outlined,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Text(
                              diaryData.contents,
                              style: AppTheme.button_small_KR.copyWith(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            Text(
                              DateHelper.convertDateAmPm(diaryData.time),
                              style: AppTheme.button_small.copyWith(
                                color: AppTheme.grey400,
                                fontSize: 11.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  static Future<void> openMapsModal({
    required BuildContext context,
  }) async {
    await showModalBottomSheet(
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        builder: (BuildContext context) {
          late GoogleMapController mapController;

          return Container(
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
              color: AppTheme.textPrimaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 15.h,
                    horizontal: 15.w,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: Navigator.of(context).pop,
                        child: Text(
                          CANCEL,
                          style: AppTheme.button_medium_KR.copyWith(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Text(
                        SELECT_LOCATION,
                        style: AppTheme.button_medium_KR.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        SEARCH,
                        style: AppTheme.button_medium_KR.copyWith(
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 300.h,
                      child: GoogleMap(
                        onMapCreated: (GoogleMapController controller) {
                          mapController = controller;
                        },
                        onCameraMoveStarted: () => {},
                        onCameraMove: (CameraPosition position) {
                          print("position");
                          print(position);
                          mapController.moveCamera(
                              CameraUpdate.newCameraPosition(position));
                        },
                        onCameraIdle: () => {},
                        initialCameraPosition: CameraPosition(
                          target: const LatLng(45.521563, -122.677433),
                          zoom: 11.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }
}
