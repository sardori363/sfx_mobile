import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sfx/src/common/styles/app_colors.dart';
import 'package:sfx/src/common/utils/extensions/context_extensions.dart';

import '../bloc/home_bloc.dart';
import '../bloc/home_state.dart';

class FilterWidget extends StatelessWidget {
  const FilterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        return SizedBox(
          height: 40,
          child: ListView.builder(
            itemCount: state.topicsData.length,
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.only(right: 8.w),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  color: BlocProvider.of<HomeBloc>(context).currentTopicId == index+1 ? AppColors.yellow : context.colorScheme.onPrimaryContainer,
                  onPressed: () {
                    if(BlocProvider.of<HomeBloc>(context).currentTopicId == index+1){
                      BlocProvider.of<HomeBloc>(context).currentTopicId = 0;
                      BlocProvider.of<HomeBloc>(context).add(GetTasksEvent(topicNumber: 0));
                    } else{
                      BlocProvider.of<HomeBloc>(context).currentTopicId = index+1;
                      BlocProvider.of<HomeBloc>(context).add(GetTasksEvent(topicNumber: index+1));
                    }
                  },
                  child: Text(
                    state.topicsData[index].name,
                    style: Theme
                        .of(context)
                        .textTheme
                        .labelMedium
                        ?.copyWith(
                        color: BlocProvider.of<HomeBloc>(context).currentTopicId == index+1 ? AppColors.black : context.colorScheme.onPrimary,
                        fontSize: 14.sp),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
