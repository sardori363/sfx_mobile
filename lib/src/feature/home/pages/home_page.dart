import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sfx/src/common/styles/app_colors.dart';
import 'package:sfx/src/common/utils/extensions/context_extensions.dart';
import 'package:sfx/src/feature/home/pages/homework_details_page.dart';
import 'package:sfx/src/feature/home/pages/success_page.dart';
import 'package:sfx/src/feature/home/widgets/filter_widget.dart';
import 'package:sfx/src/feature/home/widgets/stats_widget.dart';

import '../../../data/entity/task_model.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeBloc _homeBloc;

  @override
  void initState() {
    super.initState();
    _homeBloc = BlocProvider.of<HomeBloc>(context);
    _homeBloc.add(GetTasksEvent(topicNumber: 0));
  }

  Future<void> _onRefresh() async {
    _homeBloc.add(GetTasksEvent(topicNumber: _homeBloc.currentTopicId));
    // await Future.delayed(const Duration(seconds: 1));
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme contextColor = context.colorScheme;
    return Scaffold(
      backgroundColor: contextColor.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Uy ishlari",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(color: contextColor.onPrimary, fontSize: 20.sp),
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          if (state.pageState == HomePageState.success) {
            return RefreshIndicator(
              color: AppColors.green,
              onRefresh: _onRefresh,
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      StatisticsWidget(
                        completed: state.stats.completedTasks,
                        left: state.stats.allTasks - state.stats.completedTasks,
                        given: state.stats.allTasks,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const FilterWidget(),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.builder(
                        itemCount: state.tasksData.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          TaskWStatus currentTask = state.tasksData[index];
                          return GestureDetector(
                            onTap: () {
                              // context.push(AppRouteName.homeworkDetailsPage);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => HomeWorkDetailsPage(
                                    currentTask: currentTask,
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(bottom: 20.h),
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: contextColor.onPrimaryContainer,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Text(
                                      BlocProvider.of<HomeBloc>(context).currentTopicId == 0 ? state.topicsData[index].name : state.topicsData[BlocProvider.of<HomeBloc>(context).currentTopicId-1].name,
                                      style: Theme.of(context).textTheme.labelLarge?.copyWith(color: contextColor.onPrimary, fontSize: 16.sp),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    height: 100.h,
                                    margin: const EdgeInsets.only(top: 6, bottom: 20),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Image.network(
                                          currentTask.imageUrl,
                                          fit: BoxFit.fitWidth,
                                        )),
                                  ),
                                  Text(
                                    currentTask.title,
                                    style: Theme.of(context).textTheme.labelLarge?.copyWith(color: contextColor.onPrimary, fontSize: 16.sp),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        truncateText(currentTask.description, limit: 23),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelLarge
                                            ?.copyWith(color: contextColor.onPrimary, fontSize: 16.sp, fontWeight: FontWeight.w500),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(4),
                                            color: currentTask.status == "Approved"
                                                ? AppColors.green
                                                : currentTask.status == "Pending"
                                                    ? AppColors.yellow
                                                    : AppColors.red),
                                        child: Text(
                                          currentTask.status ?? "Left",
                                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                              color: currentTask.status == "Pending"
                                                  ? AppColors.black
                                                  : contextColor.onPrimary,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state.pageState == HomePageState.error) {
            return RefreshIndicator(
              color: AppColors.green,
                onRefresh: _onRefresh,
                child: const ErrorPage());
          } else {
            return const Center(
              child: CircularProgressIndicator(color: AppColors.green),
            );
          }
        },
      ),
    );
  }
}

String truncateText(String text, {int limit = 30}) {
  if (text.length > limit) {
    return '${text.substring(0, limit)}...';
  } else {
    return text;
  }
}
