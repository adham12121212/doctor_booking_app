<div align="center">

# 🩺 Doctor Booking App

A doctor appointment booking app built with **Flutter**, **Firebase** and **Supabase**. Patients can find doctors by speciality and book a day and time. Any user can switch to **Doctor Mode** to create a doctor profile and accept or reject incoming appointments, and the patient gets a notification either way.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Firebase](https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black)
![Supabase](https://img.shields.io/badge/Supabase-3ECF8E?style=for-the-badge&logo=supabase&logoColor=white)
![Bloc](https://img.shields.io/badge/State-Bloc%20%2F%20Cubit-8A2BE2?style=for-the-badge)

</div>

---

## ✨ Features

### 👤 Patient

- 🚀 **Splash & onboarding**: animated splash screen, plus onboarding pages shown on first launch
- 🔐 **Authentication**: sign up and login with email & password (Firebase Auth), with the session saved locally
- 🏠 **Home**: list of doctors with rating, price and availability badges, filtered by speciality (Heart Surgeon, Pharmacist, Dental Surgeon, Gynecology, ...)
- 📄 **Doctor details**: about, experience, number of patients, reviews and price, with buttons to **call** the doctor or **open the location in Google Maps**
- 📅 **Booking**: pick an appointment day and an available time slot
- 🗂️ **My appointments**: view all booked appointments
- 🔔 **Notifications**: real-time notifications when a doctor accepts or rejects an appointment

### 🩺 Doctor Mode

- 📝 **Doctor profile form**: name, speciality, experience, price and about, shown the first time Doctor Mode is opened from Settings
- 🖼️ **Profile image upload**: picked with `image_picker` and stored in **Supabase Storage**
- 📊 **Doctor dashboard**: real-time list of incoming appointments
- ✅ **Accept / reject**: done in a Firestore transaction that updates the appointment and sends a notification to the patient

---

## 🔄 Booking Flow

```
Patient                         Firestore                          Doctor
───────                         ─────────                          ──────
Book day + time  ──────────▶  user/{uid}/booked
                 ──────────▶  doctors/{doctorId}/Appointment  ──▶  Dashboard (live)
                                                                      │
                                                            Accept / Reject
                                                                      │
Notifications (live)  ◀────  user/{patientUid}/notifications  ◀───────┘
```

---

## 🏗️ Architecture

The project follows **Clean Architecture** with a **feature-first** structure:

```
feature/
 └── <feature_name>/
      ├── data/           # models (json_serializable) + repository implementations
      ├── domain/         # entities + abstract repositories
      └── presentation/   # views, widgets, cubits & states
```

- **State management:** `flutter_bloc` (Cubit)
- **Dependency injection:** `get_it`
- **Backend:** Firebase Auth + Cloud Firestore (real-time with `snapshots()`)
- **File storage:** Supabase Storage
- **Error handling:** typed `NetworkExceptions` built with `freezed`
- **Routing:** named routes through a single `onGenerateRoute`

---

## 📂 Project Structure

```
lib/
├── core/
│   ├── constants/          # colors, text styles, Firestore collection names
│   ├── error_handler/      # error model & network exceptions (freezed)
│   ├── helper_functions/   # get_it setup, shared_preferences helper
│   ├── routing/            # app routes
│   ├── service/            # Firebase Auth & Firestore services
│   └── widgets/            # shared widgets (app bar, snack bar, buttons, ...)
├── feature/
│   ├── splash/             # splash screen
│   ├── onboarding/         # onboarding pages
│   ├── auth/               # login & sign up
│   ├── root/               # bottom navigation bar
│   ├── home/               # doctors list, categories, notifications
│   ├── details/            # doctor details (call / location)
│   ├── booked/             # booking a day & time
│   ├── appointment/        # patient's appointments
│   ├── settings/           # settings & Doctor Mode entry
│   ├── doctor/             # doctor profile form + image upload
│   └── dashboard/          # doctor dashboard (accept / reject)
├── firebase_options.dart
└── main.dart
```

---

## 🗄️ Firestore Data Model

| Collection | Description |
|---|---|
| `user/{uid}` | User profile |
| `user/{uid}/booked` | The patient's booked appointments |
| `user/{uid}/notifications` | Accept / reject notifications for the patient |
| `doctors/{uid}` | Doctor profile (name, speciality, image, price, rating, experience, ...) |
| `doctors/{uid}/Appointment` | Incoming appointments for the doctor |

Doctor profile images are stored in the Supabase Storage bucket `doctors`.

---

## 🧰 Tech Stack

| Category | Packages |
|---|---|
| State management | `flutter_bloc`, `bloc` |
| Backend | `firebase_core`, `firebase_auth`, `cloud_firestore` |
| Storage | `supabase_flutter`, `image_picker` |
| Code generation | `freezed`, `json_serializable`, `build_runner` |
| Networking | `dio` |
| DI | `get_it` |
| Local storage | `shared_preferences` |
| UI | `flutter_screenutil`, `flutter_svg`, `skeletonizer`, `dots_indicator`, `modal_progress_hud_nsn` |
| Utilities | `url_launcher` (phone calls & maps) |

---

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (Dart `^3.9.2`)
- A Firebase project with **Email/Password Authentication** and **Cloud Firestore** enabled
- A Supabase project with a public Storage bucket named `doctors`

### Installation

```bash
# 1. Clone the repo
git clone https://github.com/adham12121212/doctor_booking_app.git
cd doctor_booking_app

# 2. Install dependencies
flutter pub get

# 3. Generate code (freezed, json_serializable)
dart run build_runner build --delete-conflicting-outputs

# 4. Run the app
flutter run
```

### Firebase setup

To connect the app to your own Firebase project:

```bash
dart pub global activate flutterfire_cli
flutterfire configure
```

### Supabase setup

Replace the Supabase `url` and `anonKey` in `lib/main.dart` with your project's values, then create a Storage bucket named `doctors`.

---

## 👤 Author

**Adham Bassiouny**, Flutter Developer

- GitHub: [@adham12121212](https://github.com/adham12121212)
- LinkedIn: [Adham Bassiouny](https://www.linkedin.com/in/adham-bassiouny-95637322a)
- Portfolio: [adham12121212.github.io/portfolio](https://adham12121212.github.io/portfolio)

---

<div align="center">

⭐ If you like this project, give it a star!

</div>
