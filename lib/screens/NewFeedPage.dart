import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import 'package:simple_social_media/modules/NewFeedPage/NewFeedPage.dart';

import '../config/strings.dart';
import '../utils/api_request_status.dart';
import '../widgets/body_builder.dart';
import '../widgets/cached_image.dart';
import '../widgets/loading_widget.dart';
import '../widgets/shimmer_widget.dart';

class NewFeedPage extends StatelessWidget {
  final NewFeedPageController newFeedPageC;

  const NewFeedPage(this.newFeedPageC, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringsAssets.post,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => newFeedPageC.resetLoadData(),
        child: Obx(() => BodyBuilder(
          shimmerLoading: ShimmerWidget(
            child: _shimmerWidget(),
          ),
          apiRequestStatus: newFeedPageC.pageStatus.value,
          child: _bodyHomePage(),
          reload: () => {newFeedPageC.resetLoadData()},
        )),
      ),
    );
  }

  Widget _bodyHomePage() {
    return Column(
      children: [
        Expanded(child: ListView.builder(
            controller: newFeedPageC.scrollController,
            itemCount: newFeedPageC.listPostData.length,
            itemBuilder: (BuildContext context, int index) {
              var dataView = newFeedPageC.listPostData[index];
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
            visible: newFeedPageC.loadPageMoreStatus.value
                == APIRequestStatus.loading?true:false)
      ],
    );
  }

  Widget _shimmerWidget() {
    return ListView.builder(
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
        });
  }
}