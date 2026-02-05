import 'dart:io';

import 'package:booked_app/feature/doctor/presentation/widgets/pick_image_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/widgets/animation_button.dart';
import '../../../dashboard/presentation/view/dashboard_view.dart';
import '../../../home/domain/entity/doctor_entity.dart';
import '../../../home/presentation/cubit/home_cubit.dart';
import 'custem_text_field.dart';


class DoctorViewBody extends StatefulWidget {
  const DoctorViewBody({super.key});

  @override
  State<DoctorViewBody> createState() => _DoctorViewBodyState();
}

class _DoctorViewBodyState extends State<DoctorViewBody> {

  final TextEditingController nameController = TextEditingController();
  final TextEditingController specialityController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();
  final TextEditingController priceController = TextEditingController();


  Future<String> uploadDoctorImageToSupabase({
    required String uid,
    required XFile file,
  }) async {
    final supabase = Supabase.instance.client;

    // unique name
    final fileExt = file.path.split('.').last;
    final filePath = '$uid/profile_${DateTime.now().millisecondsSinceEpoch}.$fileExt';

    await supabase.storage.from('doctors').upload(
      filePath,
      File(file.path),
      fileOptions: const FileOptions(upsert: true),
    );

    // public bucket => public url
    final imageUrl = supabase.storage.from('doctors').getPublicUrl(filePath);
    return imageUrl;
  }



  XFile? pickedImage;

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 20.0.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20.h,),
          PickImageWidget(
            onPicked: (file) {
              pickedImage = file;
            },
          ),
          SizedBox(height: 20.h,),
          CustemTextField(Controller: nameController,hintText: 'Doctor Name',),
          SizedBox(height: 20.h,),
          CustemTextField(Controller: specialityController,hintText: 'speciality',),
          SizedBox(height: 20.h,),
          Row(
            children: [
              Expanded(child: CustemTextField(Controller: experienceController,hintText: 'Experience years',)),
              SizedBox(width: 20.w,),
              Expanded(child: CustemTextField(Controller: priceController,hintText: 'Price per visit',)),

            ],
          ),
          SizedBox(height: 20.h,),
          CustemTextField(Controller: aboutController,hintText: 'about',maxLiens: 6,),
          SizedBox(height: 20.h,),
          AnimatedConfirmButton(
            height: 40.h,
            width: 300.w,
            onPressedAsync: () async {
              final uid = FirebaseAuth.instance.currentUser!.uid;

              String imageUrl = '';
              if (pickedImage != null) {
                imageUrl = await uploadDoctorImageToSupabase(uid: uid, file: pickedImage!);
              }

              final doctor = DoctorEntity(
                uid: uid,
                name: nameController.text.trim(),
                image: imageUrl, // ✅ URL من Supabase
                speciality: specialityController.text.trim(),
                rating: 4.5,
                reviews: 1220,
                price: double.tryParse(priceController.text.trim()) ?? 0.0,
                experienceYears: int.tryParse(experienceController.text.trim()) ?? 0,
                isAvailable: true,
                patients: 90,
                aboutText: aboutController.text.trim(),
              );

              await context.read<HomeCubit>().addDoctor(doctorEntity: doctor);
              Navigator.of(context).pushReplacementNamed(DoctorDashboard.routeName);
            },
            text: 'Add Doctor',
          )


        ],
      ),
    );
  }
}

