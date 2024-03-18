import '../exports.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  DateTime? lastBackPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        DateTime currentTime = DateTime.now();
        bool backButtonInterval = lastBackPressed == null ||
            currentTime.difference(lastBackPressed!) >
                const Duration(seconds: 2);

        if (backButtonInterval) {
          lastBackPressed = currentTime;
          Fluttertoast.showToast(
              msg: 'Tap again to exit', gravity: ToastGravity.TOP);

          return false;
        } else {
          return true;
        }
      },
      child: BlocBuilder<OperationCubit, OperationState>(
          builder: (context, state) {
        return Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                imageList[state.selectedDbIndex]['path']!,
                fit: BoxFit.cover,
              ),
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: SizedBox(
                  width: 360.w,
                  child: FloatingActionButton(
                    backgroundColor: Colors.blue.withOpacity(0.7),
                    onPressed: () => context
                        .pushReplacementScreen(const ImageSwitcherScreen()),
                    child: const Text('Change Background',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w500)),
                  ),
                ),
              ),
              Positioned(
                right: 16.w,
                top: 30.h,
                child: IconButton(
                  onPressed: () async {
                    // ignore: use_build_context_synchronously
                    SystemNavigator.pop();
                  },
                  icon:
                      Icon(Icons.exit_to_app, size: 44.r, color: Colors.white),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
