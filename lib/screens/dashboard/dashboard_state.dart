part of 'dashboard_bloc.dart';

// helpful navigation pages, you can change
// them to support your pages
enum NavItem {
  page_one,
  page_two,
  page_three,
  page_four,
  page_five,
  page_six,
}

class DashboardState extends Equatable {
   final NavItem? selectedItem ;
   const DashboardState({this.selectedItem = NavItem.page_one});

  @override
  // TODO: implement props
  List<Object?> get props => [selectedItem];
}


