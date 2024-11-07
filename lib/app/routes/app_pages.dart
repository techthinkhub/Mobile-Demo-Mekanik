import 'package:get/get.dart';

import '../modules/approve/bindings/approve_binding.dart';
import '../modules/approve/views/approve_edit.dart';
import '../modules/approve/views/approve_view.dart';
import '../modules/boking/bindings/boking_binding.dart';
import '../modules/boking/views/boking_view.dart';
import '../modules/boking/views/boking_view2.dart';
import '../modules/bookingmasuk/bindings/bookingmasuk_binding.dart';
import '../modules/bookingmasuk/views/bookingmasuk_view.dart';
import '../modules/detail_history/bindings/detail_history_binding.dart';
import '../modules/detail_history/views/detail_history_view.dart';
import '../modules/emergency/bindings/emergency_binding.dart';
import '../modules/emergency/views/emergency_view.dart';
import '../modules/general_checkup/bindings/general_checkup_binding.dart';
import '../modules/general_checkup/componen/startstop/startstop_p2h.dart';
import '../modules/general_checkup/componen/startstop/startstop_p2h_stop.dart';
import '../modules/general_checkup/componen/startstop/startstop_prodical.dart';
import '../modules/general_checkup/componen/startstop/startstop_prodical_stop_.dart';
import '../modules/general_checkup/views/periodical.dart';
import '../modules/general_checkup/views/step_gc.dart';
import '../modules/history/bindings/history_binding.dart';
import '../modules/history/views/history_view.dart';
import '../modules/home/absen/absen_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/componen/buttomnavigationbar.dart';
import '../modules/invoicemasuk/bindings/invoicemasuk_binding.dart';
import '../modules/invoicemasuk/views/invoicemasuk_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/promek/bindings/promek_binding.dart';
import '../modules/promek/detail/card_detailpkpsperepart.dart';
import '../modules/promek/detail/detailpkb.dart';
import '../modules/promek/detail/detailpkbview.dart';
import '../modules/promek/start_stop/start_stop_view.dart';
import '../modules/promek/views/pkb.dart';
import '../modules/repair_maintenen/bindings/repair_maintenen_binding.dart';
import '../modules/repair_maintenen/views/repair_maintenen_edit.dart';
import '../modules/repair_maintenen/views/repair_maintenen_view.dart';
import '../modules/repair_maintenen/views/repair_maintenen_view_detail.dart';
import '../modules/selesaidikerjakan/bindings/selesaidikerjakan_binding.dart';
import '../modules/selesaidikerjakan/views/selesaidikerjakan_view.dart';
import '../modules/selesaiservice/bindings/selesaiservice_binding.dart';
import '../modules/selesaiservice/views/selesaiservice_view.dart';
import '../modules/signin/bindings/signin_binding.dart';
import '../modules/signin/views/signin_view.dart';
import '../modules/splashcreen/bindings/splashcreen_binding.dart';
import '../modules/splashcreen/views/splashcreen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => const SigninView(),
      binding: SigninBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.BOKING,
      page: () => BokingView(),
      binding: BokingBinding(),
    ),
    GetPage(
      name: _Paths.BOKING2,
      page: () => BokingView3(),
      binding: BokingBinding(),
    ),
    GetPage(
      name: _Paths.PKB,
      page: () => PKBlist(),
      binding: PromekBinding(),
    ),
    GetPage(
      name: _Paths.HISTORY,
      page: () => HistoryView2(
        clearCachedBooking: () {},
      ),
      binding: HistoryBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.GENERAL_CHECKUP,
      page: () => StartStopViewG2H(),
      binding: GeneralCheckupBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.GENERAL_CHECKUP_STOP,
      page: () => StartStopViewG2HStop(),
      binding: GeneralCheckupBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.PPRODICAL_STOP,
      page: () => StartStopViewProdicalStop(),
      binding: GeneralCheckupBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.StarStopProdical,
      page: () => StarStopProdical(),
      binding: GeneralCheckupBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.MyStepperPage,
      page: () => MyStepperPage(),
      binding: GeneralCheckupBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.ListPeriodical,
      page: () => const PeriodicalList(),
      binding: GeneralCheckupBinding(),
    ),
    GetPage(
      transition: Transition.zoom,
      name: _Paths.SPLASHCREEN,
      page: () => SplashcreenView(),
      binding: SplashcreenBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.REPAIR_MAINTENEN,
      page: () => const RepairMaintenenView(),
      binding: RepairMaintenenBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.REPAIR_MAINTENENEDIT,
      page: () => const RepairMaintenenEdit(),
      binding: RepairMaintenenBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.APPROVE,
      page: () => ApproveView(),
      binding: ApproveBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.APPROVEEDIT,
      page: () => ApproveViewEdit(),
      binding: ApproveBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.BOOKINGMASUK,
      page: () => BookingmasukView(),
      binding: BookingmasukBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.SELESAISERVICE,
      page: () => const SelesaiserviceView(),
      binding: SelesaiserviceBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.SELESAIDIKERJAKAN,
      page: () => const SelesaidikerjakanView(),
      binding: SelesaidikerjakanBinding(),
    ),
    GetPage(
      transition: Transition.rightToLeftWithFade,
      name: _Paths.DETAIL_HISTORY,
      page: () => const DetailHistoryView(),
      binding: DetailHistoryBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.DETAILPKB,
      page: () => const DetailPKB(),
      binding: DetailHistoryBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.STARTSTOPPKB,
      page: () => const StartStopView(),
      binding: DetailHistoryBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.EmergencyView,
      page: () => const EmergencyView(),
      binding: mergencyBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.CardDetailPKBSperepart,
      page: () => const CardDetailPKBSperepart(),
      binding: mergencyBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.AbsenView,
      page: () => const AbsenView(),
      binding: HomeBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.DetailPKBView,
      page: () => const DetailPKBView(),
      binding: HomeBinding(),
    ),
    GetPage(
      transition: Transition.downToUp,
      name: _Paths.DetailBooking,
      page: () => const DetailBooking(),
      binding: RepairMaintenenBinding(),
    ),
    GetPage(
      name: _Paths.INVOICEMASUK,
      page: () => const InvoicemasukView(),
      binding: InvoicemasukBinding(),
    ),
  ];
}
