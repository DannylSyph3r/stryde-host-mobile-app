part of 'base_nav_wrapper.dart';

//! the state notifier provider for controlling the state of the base nav wrapper

final baseNavControllerProvider =
    StateNotifierProvider<BaseNavController, int>((ref) {
  return BaseNavController();
});

//! the state notifier class for controlling the state of the base nav wrapper
class BaseNavController extends StateNotifier<int> {
  BaseNavController() : super(0);

  //! move to page
  void moveToPage({required int index}) {
    state = index;
  }
}

//! () => move to page
void moveToPage({
  required BuildContext context,
  required WidgetRef ref,
  required int index,
}) {
  ref.read(baseNavControllerProvider.notifier).moveToPage(index: index);
}

//! List of pages
List<Widget> pages = [
  const HomeView(),
  const GarageView(),
  const CalendarView(),
  const MessagesSelectionView(),
];

enum Nav {
  home('Home', 'home', 'home_active'),
  garage('Garage', 'garage', 'garage_active'),
  calendar('Calendar', 'calendar', 'calendar_active'),
  messages('Messages', 'messages', 'messages_active');

  const Nav(
    this.label,
    this.icon,
    this.iconActive,
  );
  final String label;
  final String icon;
  final String iconActive;
}

// enum Nav{
//   home('home'),
//   garage('garage'),
//   calendar('calendar'),
//   messages('messages'),

//   const Nav(
//     this.icon,
//   );
//   final String icon;
// }

List<Nav> nav = [Nav.home, Nav.garage, Nav.calendar, Nav.messages];
