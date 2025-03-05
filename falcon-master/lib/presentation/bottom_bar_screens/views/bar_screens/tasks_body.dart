import 'package:falcon/core/core_exports.dart';


class TasksBody extends StatefulWidget {
  @override
  _TasksBodyState createState() => _TasksBodyState();
}

class _TasksBodyState extends State<TasksBody> with SingleTickerProviderStateMixin {
  late TabController _taskTabController;

  @override
  void initState() {
    super.initState();
    _taskTabController = TabController(length: 2, vsync: this);
    _taskTabController.addListener(_handleTaskTabSelection);
  }

  void _handleTaskTabSelection() {
    if (_taskTabController.indexIsChanging) {
      BlocProvider.of<TasksTabBloc>(context).add(TaskTabChanged(_taskTabController.index));
    }
  }

  @override
  void dispose() {
    _taskTabController.removeListener(_handleTaskTabSelection);
    _taskTabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        context: context,
        backgroundColor: ColorManager.white,
        elevation: 0,
        title: 'Tasks',
        appBarHeight: AppConstants.hScreen(context)*0.14,
        bottom: TabBar(
          controller: _taskTabController,
          dividerColor: ColorManager.grey,
          unselectedLabelColor:ColorManager.textGrey,
          overlayColor: WidgetStateProperty.all(ColorManager.white),
          isScrollable: false,
          labelPadding: EdgeInsets.only(left: 0, right: 0),
          labelStyle: getMediumStyle(color: ColorManager.primary,fontSize: 14),
          tabs: [
            Tab(text: 'Assignments'),
            Tab(text: 'Quizzes'),
          ],
        ),
      ),
      body: BlocBuilder<TasksTabBloc, TasksTabState>(
        builder: (context, state) {
          _taskTabController.index = state.selectedIndex;
          return TabBarView(
            controller: _taskTabController,
            children: [
              //CustomAssignmentItem(),
              //CustomQuizItem(),
            ],
          );
        },
      ),
    );
  }
}


