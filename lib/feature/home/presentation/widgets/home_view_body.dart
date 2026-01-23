import 'package:booked_app/feature/home/presentation/cubit/home_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_texts.dart';
import '../../../auth/login/presentation/cubit/login_cubit.dart';
import '../../../auth/sigup/presentation/cubit/signup_cubit.dart';
import '../../../details/presentation/view/details_view.dart';
import '../../data/model/doctor_model.dart';
import 'category.dart';
import 'doctor_card.dart';
import 'header_widget.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key, required this.doctors});

  final List<DoctorModel> doctors;



  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          pinned: true,
          elevation: 0,
          collapsedHeight: 230,
          backgroundColor: AppColors.blueColor,
          scrolledUnderElevation: 0,
          toolbarHeight: 220,
          //heading
          title: HeaderWidget(
            onChanged: (value) {
              context.read<HomeCubit>().filterBySearch(value);
            },
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Text('Categories',style:AppTextStyles.medium20 ,),
                SizedBox(height: 15,),
                CategoryHome(),
                SizedBox(height: 15,),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoading) {
                      return Column(

                        children: [
                          SizedBox(height: 180,),
                          const Center(child: CupertinoActivityIndicator()),
                        ],
                      );
                    }

                    if (state is HomeFailure) {
                      return Center(child: Text(state.error));
                    }

                    if (state is HomeSuccess) {
                      if (state.doctors.isEmpty) {
                        return  Padding(
                          padding:  EdgeInsets.all(50.0),
                          child: Image.asset('assets/category_images/searchError.jpg',
                          ),
                        );
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.doctors.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, DetailsView.routeName, arguments: state.doctors[index].id);
                              print(state.doctors[index].id);
                            },
                              child: DoctorCard(doctor: state.doctors[index]));
                        },
                      );
                    }

                    return const SizedBox.shrink();
                  },
                ),
                SizedBox(height: 40,)
              ],
            ),
          ),
        ),
      ],
    );
  }
}

