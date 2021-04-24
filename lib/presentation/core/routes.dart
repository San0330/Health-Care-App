import 'package:flutter/material.dart';

import '../admin/manage_product/manage_product.dart';
import '../admin/manage_orders/view_orders.dart';
import '../admin/manage_survey/manage_survey.dart';
import '../admin/manage_survey/survey_results.dart';
import '../admin/management_list/management_list.dart';
import '../appointment_lists_page/appointment_list.dart';
import '../auth_page/auth_page.dart';
import '../bmi_page/bmi_page.dart';
import '../diagnosis_page/diagnosis.dart';
import '../diagnosis_page/diagnosis1/diagnosis1.dart';
import '../doctor/doctors.dart';
import '../doctor_page/doctor_page.dart';
import '../doctors_list_page/doctors.dart';
import '../health_calc/health_calc.dart';
import '../home_page/home_page.dart';
import '../orders_lists_page/order_lists.dart';
import '../pedometer_page/pedometer_page.dart';
import '../products_page/products.dart';
import '../profile_page/edit_profile.dart';
import '../profile_page/profile_page.dart';
import '../splash_screen/splash_screen.dart';
import '../surveys/surveys.dart';

Map<String, Widget Function(BuildContext)> routes = {
  SplashScreen.routeName: (_) => const SplashScreen(),
  AuthPage.routeName: (_) => const AuthPage(),
  HomePage.routeName: (_) => const HomePage(),
  ProductsPage.routeName: (_) => const ProductsPage(),
  DoctorsList.routeName: (_) => const DoctorsList(),
  DoctorPage.routeName: (_) => const DoctorPage(),
  AppointmentList.routeName: (_) => const AppointmentList(),
  BMIScreen.routeName: (_) => const BMIScreen(),
  ProfileScreen.routeName: (_) => const ProfileScreen(),
  EditProfile.routeName: (_) => const EditProfile(),
  OrderListsPage.routeName: (_) => const OrderListsPage(),
  DiagnosisScreen.routeName: (_) => const DiagnosisScreen(),
  Diagnosis1.routeName: (_) => const Diagnosis1(),
  HealthCalcPage.routeName: (_) => const HealthCalcPage(),
  PedometerPage.routeName: (_) => const PedometerPage(),
  ManagementScreen.routeName: (_) => const ManagementScreen(),
  ManageProduct.routeName: (_) => const ManageProduct(),
  DoctorsAppointments.routeName: (_) => const DoctorsAppointments(),
  ManageSurvey.routeName: (_) => const ManageSurvey(),
  SurveysPage.routeName: (_) => const SurveysPage(),  
  SurveyResultsPage.routeName: (_) => const SurveyResultsPage(),
  ViewAllOrders.routeName:(_) => const ViewAllOrders(),
};
