import 'package:flutter/material.dart';

class GalleryCarousel extends StatefulWidget {
  const GalleryCarousel({Key? key, required this.galleryImages, required this.imageIndex}) : super(key: key);
  final List<String> galleryImages;
  final int imageIndex;

  @override
  State<GalleryCarousel> createState() => _GalleryCarouselState();
}

class _GalleryCarouselState extends State<GalleryCarousel> {
  late PageController _pageController;
  int _activePage = 1;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.8, initialPage: widget.imageIndex);
    _activePage = widget.imageIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child:Row(
                  children: [
                  IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.white),
                    onPressed: () {Navigator.pop(context);}
                  )],
                )
            ),
            Expanded(
              child: PageView.builder(
                  itemCount: widget.galleryImages.length,
                  pageSnapping: true,
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() {
                      _activePage = page;
                    });
                  },
                  itemBuilder: (context, pagePosition) {
                      bool active = pagePosition == _activePage;
                      return slider(widget.galleryImages, pagePosition, active);
                  }
              )
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: indicators(widget.galleryImages.length,_activePage)
              )
            )
          ]
        )
    );
}}

AnimatedContainer slider(images, pagePosition, active) {
  double margin = active ? 10 : 20;

  return AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeInOutCubic,
    margin: EdgeInsets.all(margin),
    decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(images[pagePosition]))),
  );
}

imageAnimation(PageController animation, images, pagePosition) {
  return AnimatedBuilder(
    animation: animation,
    builder: (context, widget) {
      return SizedBox(
        width: 200,
        height: 200,
        child: widget,
      );
    },
    child: Container(
      margin: const EdgeInsets.all(10),
      child: Image.network(images[pagePosition]),
    ),
  );
}

List<Widget> indicators(imagesLength, currentIndex) {
  return List<Widget>.generate(imagesLength, (index) {
    return Container(
      margin: const EdgeInsets.all(3),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
          color: currentIndex == index ? Colors.white : Colors.white24,
          shape: BoxShape.circle),
    );
  });
}