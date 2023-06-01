import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:simple_social_media/modules/DetailUserScreen/DetailUserScreen.dart';
import 'package:simple_social_media/widgets/cached_image.dart';

import '../config/strings.dart';
import '../utils/api_request_status.dart';
import '../widgets/body_builder.dart';
import '../widgets/loading_widget.dart';
import '../widgets/shimmer_widget.dart';

class DetailUserScreen extends StatelessWidget {
  final DetailUserScreenController detailUserScreenC;

  const DetailUserScreen(this.detailUserScreenC, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          child: Icon(EvaIcons.arrowBack),
          onTap: (){
            Get.back();
          },
        ),
        title: Text(
          "",
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => detailUserScreenC.resetLoadData(),
        child: Obx(() => BodyBuilder(
          shimmerLoading: ShimmerWidget(
            child: _shimmerWidget(),
          ),
          apiRequestStatus: detailUserScreenC.pageStatus.value,
          child: _bodyPage(),
          reload: () => {detailUserScreenC.resetLoadData()},
        )),
      ),
    );
  }

  Widget _bodyPage(){
    var dataView = detailUserScreenC.detailUserData.value;
    return Padding(
        padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(EvaIcons.personAdd, size: 100, color: Color(0xff2b95ea),),
              Gap(30.w),
              ClipRRect(
                borderRadius: BorderRadius.circular(100.0),
                child: CachedImage(
                  imageUrl: dataView.picture??"",
                  height: 100.h,
                  width: 100.w,
                ),
              ),
            ],
          ),
          Gap(5.h),
          Center(
            child: Text(
              "${dataView.title?.toUpperCase()} ${dataView.firstName} ${dataView.lastName}",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w900
              ),
            ),
          ),
          Gap(10.h),
          Row(
            children: [
              Text(
                StringsAssets.gender,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700
                ),
              ),
              Gap(5.w),
              Text(
                dataView.gender??"",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
          Gap(10.h),
          Row(
            children: [
              Text(
                StringsAssets.dob,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700
                ),
              ),
              Gap(5.w),
              Text(
                dataView.dateOfBirth??"",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
          Gap(10.h),
          Row(
            children: [
              Text(
                StringsAssets.joinFrom,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700
                ),
              ),
              Gap(5.w),
              Text(
                dataView.registerDate??"",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
          Gap(10.h),
          Row(
            children: [
              Text(
                StringsAssets.email,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700
                ),
              ),
              Gap(5.w),
              Text(
                dataView.email??"",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400
                ),
              ),
            ],
          ),
          Gap(10.h),
          Row(
            children: [
              Text(
                StringsAssets.addressFrom,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700
                ),
              ),
              Gap(5.w),
              Expanded(child: Text(
                "${dataView.location?.street}, ${dataView.location?.city}, "
                    "${dataView.location?.state}, ${dataView.location?.country}",
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400
                ),
              ),)
            ],
          ),
          Gap(20.h),
          Divider(
            color: Color(0xff888888),
          ),
          Gap(10.h),
          Expanded(child: ListView.builder(
              controller: detailUserScreenC.scrollController,
              itemCount: detailUserScreenC.listPostByUserData.length,
              itemBuilder: (BuildContext context, int index) {
                var dataView = detailUserScreenC.listPostByUserData[index];
                var tags = "";
                for (var tagsTemp in dataView.tags??[]) {
                  tags += tagsTemp+", ";
                }
                return Card(
                  color: const Color(0xffffffff),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(100.0),
                          child: CachedImage(
                            imageUrl: dataView.owner?.picture??"",
                            height: 40.h,
                            width: 40.w,
                          ),
                        ),
                        Gap(10.w),
                        Expanded(child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "${dataView.owner?.firstName} ${dataView.owner?.lastName}",
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            Gap(5.h),
                            Text(
                              "${dataView.publishDate} ",
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                            Gap(10.h),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: CachedImage(
                                imageUrl: dataView.image??"",
                                width: Get.width,
                              ),
                            ),
                            Gap(10.h),
                            Text(
                              tags,
                              style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600
                              ),
                            ),
                            Gap(10.h),
                            Text(
                              dataView.text??"",
                              style: TextStyle(
                                fontSize: 12.sp,
                              ),
                            ),
                            Gap(10.h),
                            Text(
                              "${dataView.likes} Likes",
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Color(0xffd73434)
                              ),
                            ),
                            Gap(5.h),
                            Row(
                              children: [
                                Icon(EvaIcons.heartOutline),
                                Gap(10.w),
                                Text(
                                  "Like",
                                  style: TextStyle(
                                      fontSize: 12.sp
                                  ),
                                ),
                              ],
                            )
                          ],
                        ))
                      ],
                    ),
                  ),
                );
              })),
          Visibility(child: const LoadingWidget(),
              visible: detailUserScreenC.loadPageMoreStatus.value
                  == APIRequestStatus.loading?true:false)
        ],
      ),
    );
  }

  Widget _shimmerWidget() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
           Container()
          ],
        ),
        Gap(5.h),
        Center(
          child: Text(
            "",
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w900
            ),
          ),
        ),
        Gap(10.h),
        Row(
          children: [
            Text(
              StringsAssets.gender,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700
              ),
            ),
            Gap(5.w),
          ],
        ),
        Gap(10.h),
        Row(
          children: [
            Text(
              StringsAssets.dob,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700
              ),
            ),
            Gap(5.w),
          ],
        ),
        Gap(10.h),
        Row(
          children: [
            Text(
              StringsAssets.joinFrom,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700
              ),
            ),
            Gap(5.w),
          ],
        ),
        Gap(10.h),
        Row(
          children: [
            Text(
              StringsAssets.email,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700
              ),
            ),
            Gap(5.w),
          ],
        ),
        Gap(10.h),
        Row(
          children: [
            Text(
              StringsAssets.addressFrom,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700
              ),
            ),
            Gap(5.w),
          ],
        ),
        Gap(20.h),
        Divider(
          color: Color(0xff888888),
        ),
        Gap(10.h),
        Expanded(child: ListView.builder(
            itemCount: 10,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: const Color(0xffffffff),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  width: Get.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(),
                      Gap(10.w),
                      Expanded(child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "",
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Gap(5.h),
                          Text(
                            "",
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                          Gap(10.h),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Container(),
                          ),
                          Gap(10.h),
                          Text(
                            "",
                            style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          Gap(10.h),
                          Text(
                            "",
                            style: TextStyle(
                              fontSize: 12.sp,
                            ),
                          ),
                          Gap(10.h),
                          Text(
                            "Likes",
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: Color(0xffd73434)
                            ),
                          ),
                          Gap(5.h),
                          Row(
                            children: [
                              Icon(EvaIcons.heartOutline),
                              Gap(10.w),
                              Text(
                                "Like",
                                style: TextStyle(
                                    fontSize: 12.sp
                                ),
                              ),
                            ],
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              );
            }))
      ],
    );
  }
}