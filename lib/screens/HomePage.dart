import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:simple_social_media/config/config.dart';

import 'package:simple_social_media/modules/HomePage/HomePage.dart';
import 'package:simple_social_media/routes/routes.dart';
import 'package:simple_social_media/utils/api_request_status.dart';
import 'package:simple_social_media/widgets/loading_widget.dart';

import '../widgets/body_builder.dart';
import '../widgets/cached_image.dart';
import '../widgets/shimmer_widget.dart';

class HomePage extends StatelessWidget {
  final HomePageController homePageC;

  const HomePage(this.homePageC, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringsAssets.users,
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: () => homePageC.resetLoadData(),
        child: Obx(() => BodyBuilder(
              shimmerLoading: ShimmerWidget(
                child: _shimmerWidget(),
              ),
              apiRequestStatus: homePageC.pageStatus.value,
              child: _bodyHomePage(),
              reload: () => {homePageC.resetLoadData()},
            )),
      ),
    );
  }

  Widget _bodyHomePage() {
    return Column(
      children: [
        Expanded(child: GridView.builder(
            controller: homePageC.scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in the grid
            ),
            itemCount: homePageC.listUserData.length, // Total number of items in the grid
            itemBuilder: (BuildContext context, int index) {
              var dataView = homePageC.listUserData[index];
              return GestureDetector(
                onTap: () {
                  Get.toNamed(Routes.detailUser, arguments: [
                    dataView.id.toString()
                  ]);
                },
                child: Card(
                  margin: EdgeInsets.all(8),
                  elevation: 4,
                  color: const Color(0xffffffff),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: CachedImage(
                                imageUrl: dataView.picture ?? "",
                                fit: BoxFit.fill,
                              )),
                        ),
                        Gap(5.h),
                        Text(
                          "${dataView.title?.toUpperCase()} ${dataView.firstName} ${dataView.lastName}",
                          style:
                          TextStyle(fontSize: 14.sp, color: Color(0xff000000)),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),),
        Visibility(child: const LoadingWidget(),
          visible: homePageC.loadPageMoreStatus.value
              == APIRequestStatus.loading?true:false)
      ],
    );
  }

  Widget _shimmerWidget() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Number of columns in the grid
        ),
        itemCount: 10, // Total number of items in the grid
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 4,
            color: const Color(0xffffffff),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          );
        });
  }
}
