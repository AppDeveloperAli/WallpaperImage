import 'package:image_switch_pro/methods/method_channel.dart';

import '../../exports.dart';

class OperationCubit extends Cubit<OperationState> {
  OperationCubit()
      : super(OperationState(
            selectedIndex: 0, isLoading: false, selectedDbIndex: 0));
  void updateIndex(int newIndex) async {
    await DatabaseHelper.instance.updateSelectedIndex(newIndex);
    emit(state.copyWith(selectedIndex: newIndex));
  }

  void updateIsLoading(bool isloading) {
    emit(state.copyWith(isLoading: isloading));
  }

  Future<void> saveImageToTemporaryDirectory(
      BuildContext context, String assetPath, int index) async {
    try {
      updateIsLoading(true);

      // Load image bytes from rootBundle
      ByteData data = await rootBundle.load(assetPath);
      Uint8List bytes = data.buffer.asUint8List();

      // Get the temporary directory
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;

      // Create a file in the temporary directory
      File imageFile = File('$tempPath/${assetPath.split('/').last}');

      // Write the image bytes to the file
      await imageFile.writeAsBytes(bytes);

      if (imageFile.path.isNotEmpty) {
        if (Platform.isAndroid) {
          int location = WallpaperManager.BOTH_SCREEN;
          bool result = await WallpaperManager.setWallpaperFromFile(
              imageFile.path, location);
          if (result) {
            // ignore: use_build_context_synchronously
            context.read<OperationCubit>().updateIndex(index);
            emit(state.copyWith(selectedDbIndex: index));
            await Fluttertoast.showToast(
              msg: "Wallpaper changed.",
              gravity: ToastGravity.TOP,
            );
          }
        } else {
          context.read<OperationCubit>().updateIndex(index);
          await WallpaperChanger.changeWallpaper(imageFile.path);
        }
        // ignore: use_build_context_synchronously
        context.pushReplacementScreen(HomeScreen());
      }
      updateIsLoading(false);
    } catch (e) {
      await Fluttertoast.showToast(
        msg: "Something went wrong. try again!",
        gravity: ToastGravity.TOP,
      );
    }
    updateIsLoading(false);
  }

  Future<void> getIndex() async {
    int index = await DatabaseHelper.instance.getSelectedIndex();

    emit(state.copyWith(selectedIndex: index, selectedDbIndex: index));
  }
}

class OperationState {
  final int selectedIndex;
  final int selectedDbIndex;
  final bool isLoading;
  OperationState(
      {required this.selectedIndex,
      required this.isLoading,
      required this.selectedDbIndex});

  OperationState copyWith(
      {int? selectedIndex, int? selectedDbIndex, bool? isLoading}) {
    return OperationState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      isLoading: isLoading ?? this.isLoading,
      selectedDbIndex: selectedDbIndex ?? this.selectedDbIndex,
    );
  }
}
