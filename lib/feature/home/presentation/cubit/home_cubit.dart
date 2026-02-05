import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../../core/error_handler/network_exceptions.dart';
import '../../../auth/logic/domain/repo/auth_repo.dart';
import '../../domain/entity/doctor_entity.dart';
import '../../domain/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this.homeRepo,this.authRepo) : super(HomeInitial());

  final HomeRepo homeRepo;
  final AuthRepo authRepo;

  List<DoctorEntity> allDoctors = [];
  List<DoctorEntity> doctorsFiltered = [];
  int selectedCategory = 0;

  final Map<String, String> categoriesMap = const {
    "assets/category_images/all.png": ?null,
    "assets/category_images/Heart.png": "Heart Surgeon",
    "assets/category_images/Pil.png": "Pharmacist",
    "assets/category_images/Dentist.png": "Dental Surgeon",
    "assets/category_images/Pregnant.png": "Gynecology",
  };

  Future<void> getDoctors() async {
    emit(HomeLoading());
    try {
      allDoctors = await homeRepo.getDoctors();
      doctorsFiltered = List.from(allDoctors);
      emit(HomeSuccess(doctors: doctorsFiltered));
    } catch (e) {
      emit(HomeFailure(error: e.toString()));
    }
  }

  Future<void> signOut()async{
    await authRepo.signOut();
    emit(HomeInitial());
  }

  void filterByCategory(String? speciality, int index) {
    selectedCategory = index;

    if (speciality == null) {
      doctorsFiltered = List.from(allDoctors);
    } else {
      doctorsFiltered = allDoctors
          .where((doctor) =>
          doctor.speciality.toLowerCase().startsWith(speciality.toLowerCase()))
          .toList();
    }

    emit(HomeSuccess(doctors: doctorsFiltered));
  }

  void filterBySearch(String search) {

    final filterSearch = allDoctors.where((doctor) {
      return doctor.name.toLowerCase().trim().contains(search.toLowerCase().trim());
    }).toList();

    emit(HomeSuccess(doctors: filterSearch));
  }
  // may be used in the future
  void resetFilter() {
    selectedCategory = 0;
    final defaultSpeciality = categoriesMap.values.elementAt(selectedCategory);

    final filteredDoctors = allDoctors.where((doctor) {
      return doctor.speciality.toLowerCase().trim() ==
          defaultSpeciality.toLowerCase().trim();
    }).toList();

    emit(HomeSuccess(doctors: filteredDoctors));
  }

  Future<void> addDoctor({required DoctorEntity doctorEntity}) async{
    emit(HomeLoading());
    try{
      await homeRepo.addDoctor(doctorEntity: doctorEntity);
      final updatedDoctors = await homeRepo.getDoctors();
      emit(HomeSuccess(doctors: updatedDoctors));
    }catch(e){
      emit(HomeFailure(error: e.toString()));
    }
  }



}
