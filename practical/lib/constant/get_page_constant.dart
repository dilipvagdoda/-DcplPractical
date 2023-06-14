import 'package:get/get.dart';
import 'package:practical/constant/route_constant.dart';
import 'package:practical/tab/home_binding.dart';
import 'package:practical/tab/home_view.dart';
import 'package:practical/tab/widget/user_details_binding.dart';
import 'package:practical/tab/widget/user_details_view.dart';


List<GetPage> getPages = [

  GetPage(name: RouteConstant.homeScreen, page: () => const HomeView(), binding: HomeBinding(),),
  GetPage(name: RouteConstant.userDetailsView, page: () => const UserDetailsView(), binding: UserDetailsBinding(),),
];