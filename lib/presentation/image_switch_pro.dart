import '../exports.dart';

class ImageSwitcherScreen extends StatelessWidget {
  const ImageSwitcherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.pushReplacementScreen(HomeScreen());
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              context.pushReplacementScreen(HomeScreen());
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          title: const Text(
            'Image Switch Pro',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue.withOpacity(0.8),
        ),
        body: GridView.builder(
          itemCount: imageList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemBuilder: (context, index) => Tile(index: index),
        ),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({super.key, required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<OperationCubit>().updateIndex(index);
        context.pushScreen(const PreviewScreen());
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            left: BorderSide(color: Colors.black.withOpacity(0.4), width: 1.0),
            bottom:
                BorderSide(color: Colors.black.withOpacity(0.4), width: 1.0),
          ),
        ),
        child: Image.asset(imageList[index]['path']!, fit: BoxFit.cover),
      ),
    );
  }
}
