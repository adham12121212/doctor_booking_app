import 'package:booked_app/feature/auth/sigup/presentation/cubit/signup_cubit.dart';
import 'package:booked_app/feature/home/presentation/cubit/home_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../auth/login/presentation/cubit/login_cubit.dart';
import '../view/notification_view.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({
    super.key, required this.onChanged,
  });

  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    int count =1;

  return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<SignupCubit, SignupState>(
              builder: (context, state) {
                String displayName = '';
                if (state is SignupSuccess) {
                  displayName = state.userEntity.name;
                   print(displayName);
                }

                return Text(
                  displayName.isNotEmpty ? 'Hi,${displayName}' : 'Guest',
                  style: AppTextStyles.medium20.copyWith(
                    color: Colors.white,
                  ),
                );
              },
            ),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, NotificationView.routeName);
              },
              child: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.white38,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Badge(
                  label: Text(count > 10 ? '10+' : '$count'),
                  largeSize: 19,
                  child: Center(
                    child: Icon(
                      size: 30,
                      Icons.notifications_none_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        Text(
          'Let’s find\nyour top doctor!',
          style: AppTextStyles.semiBold32.copyWith(
            color: Colors.white,
          ),
        ),
        SizedBox(height: 10),
        //search
        TextField(
          onChanged: onChanged,
          cursorHeight: 15,
          cursorColor: Colors.black,
          decoration: InputDecoration(
            hintText: 'Search here...',
            hintStyle: TextStyle(color: Colors.black38),
            contentPadding: EdgeInsets.symmetric(vertical: 15),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: Icon(
                CupertinoIcons.search,
                size: 28,
                color: Colors.black38,
              ),
            ),
            fillColor: Colors.white,
            filled: true,
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(64),
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(64),
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
