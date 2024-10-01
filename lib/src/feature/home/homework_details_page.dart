import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sfx/generated/assets.dart';
import 'package:sfx/src/common/styles/app_colors.dart';
import 'package:sfx/src/common/utils/extensions/context_extensions.dart';
import 'package:sfx/src/data/entity/task_model.dart';
import 'package:sfx/src/feature/home/widgets/custom_button.dart';

class HomeWorkDetailsPage extends StatelessWidget {
  const HomeWorkDetailsPage({super.key, required this.currentTask});

  final Task currentTask;

  @override
  Widget build(BuildContext context) {
    ColorScheme contextColor = context.colorScheme;
    return Scaffold(
      backgroundColor: contextColor.background,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                SizedBox(
                  height: 214,
                  width: double.infinity,
                  child: ClipRRect(borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12)), child: Image.network(currentTask.imageUrl, fit: BoxFit.fill,)),
                ),
                Positioned(
                  top: 20,
                  left: 12,
                  child: CustomButton(
                    icon: Icons.arrow_back_outlined,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    currentTask.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: contextColor.onPrimary, fontWeight: FontWeight.w700, fontSize: 18.sp),
                  ),
                  Text(
                    currentTask.description,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: contextColor.onPrimary, fontWeight: FontWeight.w500, fontSize: 14.sp),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Upload files",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: contextColor.onPrimary, fontWeight: FontWeight.w700, fontSize: 18.sp),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    height: 170.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: contextColor.onPrimaryContainer,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: AppColors.yellow, width: 2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(Assets.iconsDocumentUpload),
                        Text(
                          "Uyga vazifani joylash",
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium
                              ?.copyWith(color: contextColor.onPrimary, fontWeight: FontWeight.w500, fontSize: 14.sp),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            minimumSize: const Size(40, 40),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                            backgroundColor: const Color(0xFFC3C9D1),
                            overlayColor: AppColors.black,
                          ),
                          child: Text(
                            "Rasm tanlsh",
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700, fontSize: 14.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 6,
                  ),
                  Text(
                    "Ruhsat etilgan fayl tiplari: .jpg va .png. Ruhsat etilgan fayl hajmi 10mbgacha",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: const Color(0xffA7A7A7), fontWeight: FontWeight.w500, fontSize: 12.sp),
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  ListView.builder(
                    itemCount: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(8),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: contextColor.onPrimaryContainer,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 50.h,
                                  width: 50.w,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFD9D9D9),
                                      borderRadius: BorderRadius.circular(6)),
                                ),
                                const SizedBox(width: 8,),
                                Column(
                                  children: [
                                    Text(
                                      "2024-10-08",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                        color: contextColor.onPrimary,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16.sp),
                                    ),
                                    Text(
                                      "1 mb | 53% - 2 sec left",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                          color: const Color(0xFFA7A7A7),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 12.sp),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              width: double.infinity,
                              child: LinearProgressIndicator(
                                backgroundColor: Color(0xFFC3C9D1),
                                color: AppColors.green,
                                minHeight: 3,
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
