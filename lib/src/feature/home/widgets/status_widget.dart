import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sfx/src/common/styles/app_colors.dart';
import 'package:sfx/src/common/utils/extensions/context_extensions.dart';
import 'package:sfx/src/data/entity/student_task_model.dart';
import 'package:sfx/src/feature/home/bloc/home_bloc.dart';

import '../bloc/home_state.dart';

class StatusWidget extends StatelessWidget {
  const StatusWidget({super.key, required this.currentTask, required this.index});
  final int currentTask;
  final int index;

  @override
  Widget build(BuildContext context) {
    ColorScheme contextColor = context.colorScheme;
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        StudentTask? currentStudentTask = state.studentTaskData[index-4];
        log("currentStudentTask.task : ${currentStudentTask.task}");
        log("currentTask : $currentTask");
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: currentStudentTask.task == currentTask && currentStudentTask.status == "Approved" ? AppColors.green : currentStudentTask.task == currentTask && currentStudentTask.status == "Pending" ? AppColors.yellow : AppColors.red),
          child: Text(
            currentStudentTask.task == currentTask ? currentStudentTask.status : "Left",
            style: Theme
                .of(context)
                .textTheme
                .titleMedium
                ?.copyWith(color: currentStudentTask.task == currentTask && currentStudentTask.status == "Pending" ? AppColors.black : contextColor.onPrimary, fontWeight: FontWeight.w600, fontSize: 16.sp),
          ),
        );
      },
    );
  }
}
