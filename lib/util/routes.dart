import 'package:flutter/widgets.dart';
import 'package:merchant/details/details_screen.dart';
import 'package:merchant/ui/auth/forget_password/forget_password_screen.dart';
import 'package:merchant/ui/auth/login/login_screen.dart';
import 'package:merchant/ui/auth/signup/signup_screen.dart';
import 'package:merchant/ui/auth/verification/verification_screen.dart';
import 'package:merchant/ui/home/components/branches/details/branch_details_screen.dart';
import 'package:merchant/ui/home/components/branches/details/screens/branch_offers/branch_new_offer/branch_new_offer_screen.dart';
import 'package:merchant/ui/home/components/branches/new_branch/new_branch_screen.dart';
import 'package:merchant/ui/home/components/couriers/courier_screen.dart';
import 'package:merchant/ui/home/components/couriers/new_courier/new_courier_screen.dart';
import 'package:merchant/ui/home/components/orders/order_change_courier/order_courier_screen.dart';
import 'package:merchant/ui/home/components/orders/order_details/order_details_screen.dart';
import 'package:merchant/ui/home/components/orders/order_screen.dart';
import 'package:merchant/ui/home/components/orders/search/search_screen.dart';
import 'package:merchant/ui/home/components/product/comments/comments_screen.dart';
import 'package:merchant/ui/home/components/product/offers/new_offer/new_offer_screen.dart';
import 'package:merchant/ui/home/components/product/search/search_screen.dart';
import 'package:merchant/ui/home/components/product/show_all_branches/product_branches_filter_screen.dart';
import 'package:merchant/ui/home/home_screen.dart';
import 'package:merchant/ui/profile/components/bank_account/bank_account_screen.dart';
import 'package:merchant/ui/profile/components/reports/reports_screen.dart';
import 'package:merchant/ui/profile/components/security/security_screen.dart';
import 'package:merchant/ui/profile/notification/notifiction_screen.dart';
import 'package:merchant/ui/profile/profile_screen.dart';
import 'package:merchant/ui/splash/splash_screen.dart';
import '../ui/auth/confirm_verification/confirm_verification_screen.dart';
import '../ui/home/components/orders/client_location/location_screen.dart';
import '../ui/home/components/product/filter/filter_screen.dart';
import '../ui/home/components/product/new_product/new_product_screen.dart';
import '../ui/profile/notification/notification_details/notification_details_screen.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  LoginScreen.routeName: (context) => const LoginScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  ForgetPasswordScreen.routeName: (context) => const ForgetPasswordScreen(),
  VerificationScreen.routeName: (context) => const VerificationScreen(),
  ConfirmVerificationScreen.routeName: (context) =>
      const ConfirmVerificationScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  CourierScreen.routeName: (context) => const CourierScreen(),
  DetailsScreen.routeName: (context) => const DetailsScreen(),
  OrderScreen.routeName: (context) => const OrderScreen(),
  ProfileScreen.routeName: (context) => const ProfileScreen(),
  NewBranchScreen.routeName: (context) => const NewBranchScreen(),
  BranchDetailsScreen.routeName: (context) => const BranchDetailsScreen(),
  NewCourierScreen.routeName: (context) => const NewCourierScreen(),
  SecurityScreen.routeName: (context) => const SecurityScreen(),
  ReportScreen.routeName: (context) => const ReportScreen(),
  BankAccountScreen.routeName: (context) => const BankAccountScreen(),
  NewProductScreen.routeName: (context) => const NewProductScreen(),
  ProductBranchesFilterScreen.routeName: (context) =>
      const ProductBranchesFilterScreen(),
  NewOfferScreen.routeName: (context) => const NewOfferScreen(),
  SearchScreen.routeName: (context) => const SearchScreen(),
  FilterScreen.routeName: (context) => const FilterScreen(),
  CommentsScreen.routeName: (context) => const CommentsScreen(),
  OrderSearchScreen.routeName: (context) => const OrderSearchScreen(),
  OrderDetailsScreen.routeName: (context) => const OrderDetailsScreen(),
  NotificationScreen.routeName: (context) => const NotificationScreen(),
  NotificationDetailsScreen.routeName: (context) =>
      const NotificationDetailsScreen(),
  BranchNewOfferScreen.routeName: (context) => const BranchNewOfferScreen(),
  LocationScreen.routeName: (context) => const LocationScreen(),
  OrderChangeCourierScreen.routeName: (context) => const OrderChangeCourierScreen()
};
