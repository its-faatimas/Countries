import 'package:flutter/material.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key}) : super(key: key);

  @override
  _PreviewPageState createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  Size? _size;
  int _currentIndex = 0;

  Color _white = Colors.white;
  Color _grey = Colors.grey;
  Color _black = Colors.black;
  Color _transparent = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: false,
      appBar: _getAppbar(),
      body: _getBody(),
    );
  }

  Stack _showImages() => Stack(
        children: [
          Container(
            height: _size!.height * 0.3,
            color: Colors.green,
            child: PageView(
              onPageChanged: (i) {
                setState(() {
                  _currentIndex = i;
                });
              },
              children: [
                _setImage("https://source.unsplash.com/random/1"),
                _setImage("https://source.unsplash.com/random/2"),
                _setImage("https://source.unsplash.com/random/3"),
                _setImage("https://source.unsplash.com/random/4"),
              ],
            ),
          ),
          _showSmoothIndicator(),
        ],
      );

  Image _setImage(imageUrl) => Image.network(
        "https://source.unsplash.com/random/1",
        fit: BoxFit.cover,
      );

  Positioned _showSmoothIndicator() => Positioned(
        left: 24.0,
        bottom: 16.0,
        child: Row(
          children: List.generate(
            4,
            (index) => Container(
              margin: const EdgeInsets.only(right: 6.0),
              width: _currentIndex == index ? 16.0 : 6.0,
              height: 6.0,
              decoration: BoxDecoration(
                color: _currentIndex == index ? Colors.green : Colors.grey,
                borderRadius: BorderRadius.circular(100.0),
              ),
            ),
          ),
        ),
      );

  Widget _getButtons(IconData icon) {
    return CircleAvatar(
      child: IconButton(
        onPressed: () {},
        icon: Icon(icon),
      ),
    );
  }

  Widget _getBody() => SingleChildScrollView(
        child: Column(
          children: [
            _showImages(),
            Text("Meadow Spring Golf And Country Club")
          ],
        ),
      );

  AppBar _getAppbar() => AppBar(
        backgroundColor: _transparent,
        elevation: 0,
      );

}


