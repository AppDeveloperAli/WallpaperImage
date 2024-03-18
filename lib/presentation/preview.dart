import '../exports.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OperationCubit, OperationState>(
        builder: (context, state) {
      return WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
          body: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              Image.asset(
                imageList[state.selectedIndex]["path"]!,
                fit: BoxFit.cover,
              ),

              // Overlay with Button
              Positioned(
                left: 16,
                right: 16,
                bottom: 16,
                child: SizedBox(
                  width: 360.w,
                  child: FloatingActionButton(
                    backgroundColor: Colors.blue.withOpacity(0.9),
                    onPressed: () async {
                      await context
                          .read<OperationCubit>()
                          .saveImageToTemporaryDirectory(
                              context,
                              imageList[state.selectedIndex]["path"]!,
                              state.selectedIndex);
                    },
                    child: state.isLoading
                        ? const Center(
                            child:
                                CircularProgressIndicator(color: Colors.white),
                          )
                        : const Text(
                            'Set Wallpaper Both',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 30.h,
                child: IconButton(
                  onPressed: () async {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.cancel_rounded,
                      size: 44.r, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
