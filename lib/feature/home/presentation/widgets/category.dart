import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/home_cubit.dart';

class CategoryHome extends StatelessWidget {
   CategoryHome({super.key});

  final Map<String, String?> categoriesMap =  {
    "assets/category_images/select-all.png": null,
    "assets/category_images/Heart.png": "Heart Surgeon",
    "assets/category_images/Pil.png": "Pharmacist",
    "assets/category_images/Dentist.png": "Dental Surgeon",
    "assets/category_images/Pregnant.png": "Gynecology",
  };

  @override
  Widget build(BuildContext context) {
    final categoriesImages = categoriesMap.keys.toList();
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final cubit = context.read<HomeCubit>();
        final selectedCategory = cubit.selectedCategory;

        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(categoriesImages.length, (index) {
              final isSelected = selectedCategory == index;

              return GestureDetector(
                onTap: () {
                  final selectedSpeciality = categoriesMap[categoriesImages[index]];
                  cubit.filterByCategory(selectedSpeciality, index);
                },
                child: Container(
                  height: 70,
                  width: 70,
                   margin: const EdgeInsets.symmetric(horizontal: 10),
                   decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? Colors.blue.shade50 : Colors.white,
                  ),
                  child: Image.asset(
                    categoriesImages[index],
                    width: 60,
                    height:60,
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
