import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_texts.dart';
import '../cubit/booked_cubit.dart';

class AppointmentDayWidget extends StatefulWidget {
  const AppointmentDayWidget({super.key});

  @override
  State<AppointmentDayWidget> createState() => _AppointmentDayWidgetState();
}

class _AppointmentDayWidgetState extends State<AppointmentDayWidget> {
  late final List<DateTime> weekDays;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();

    DateTime startOfWeek = getStartOfWeek(now);
    DateTime thursday = startOfWeek.add(const Duration(days: 4));

    // 👇 لو الخميس عدى → نعرض الأسبوع اللي بعده
    if (now.isAfter(thursday)) {
      startOfWeek = startOfWeek.add(const Duration(days: 7));
    }

    weekDays = List.generate(
      5,
          (index) => startOfWeek.add(Duration(days: index)),
    );

    // اختيار اليوم الحالي تلقائيًا لو موجود
    selectedIndex = weekDays.indexWhere(
          (day) =>
      day.day == now.day &&
          day.month == now.month &&
          day.year == now.year,
    );

    if (selectedIndex == -1 || isDayDisabled(weekDays[selectedIndex])) {
      selectedIndex = 0;
    }
  }

  // بداية الأسبوع (Sunday)
  DateTime getStartOfWeek(DateTime date) {
    return date.subtract(Duration(days: date.weekday % 7));
  }

  // هل اليوم منتهي؟
  bool isDayDisabled(DateTime day) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDay = DateTime(day.year, day.month, day.day);

    return targetDay.isBefore(today);
  }

  // اسم اليوم
  String getWeekDayName(DateTime date) {
    switch (date.weekday) {
      case DateTime.sunday:
        return 'Sun';
      case DateTime.monday:
        return 'Mon';
      case DateTime.tuesday:
        return 'Tues';
      case DateTime.wednesday:
        return 'Wed';
      case DateTime.thursday:
        return 'Thurs';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        height: 87.h,
        width: 400.w,
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 5),
            )
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(weekDays.length, (index) {
            final bool isDisabled = isDayDisabled(weekDays[index]);
            final bool isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: isDisabled
                  ? null
                  : () {
                setState(() {
                  selectedIndex = index;
                });

                final dayName = getWeekDayName(weekDays[index]);
                context.read<BookedCubit>().selectDay(dayName);
              },

              child: Container(
                width: 55.w,
                height: 67.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: isDisabled
                      ? Colors.grey.shade200
                      : isSelected
                      ? AppColors.blueColor
                      : Colors.white,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      getWeekDayName(weekDays[index]),
                      style: AppTextStyles.semiBold16.copyWith(
                        color: isDisabled
                            ? Colors.grey
                            : isSelected
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      weekDays[index].day.toString(),
                      style: AppTextStyles.semiBold13.copyWith(
                        color: isDisabled
                            ? Colors.grey
                            : isSelected
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}
