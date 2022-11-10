import 'package:flutter/material.dart';
import 'package:context_menus/context_menus.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        body: Column(
          children: const [
            Expanded(child: DefaultMenuTests()),
            Expanded(child: StyledMenuTests()),
            Expanded(child: CustomMenuTests()),
          ],
        ),
      ),
    );
  }
}

/// Presents the tests with default styling
class DefaultMenuTests extends StatelessWidget {
  const DefaultMenuTests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ContextMenuOverlay(child: const TestContent(title: "Default Menus"));
}

class StyledMenuTests extends StatelessWidget {
  const StyledMenuTests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green.shade200,
      child: ContextMenuOverlay(
        blockPointer: false,
          buttonStyle: ContextMenuButtonStyle(
            fgColor: Colors.green,
            bgColor: Colors.green.shade100,
            hoverFgColor: Colors.green,
            hoverBgColor: Colors.green.shade200,
          ),
          child: const TestContent(title: "Styled Menus")),
    );
  }
}

/// Presents the tests with custom styling
class CustomMenuTests extends StatelessWidget {
  const CustomMenuTests({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [
        Container(color: Colors.blue.shade200,
            child: GestureDetector(
              onSecondaryTap: (){
                print("onSecondaryTap");
                ContextMenuOverlayController.getShow(Container(width: 200,height: 200,color: Colors.red,), tag:"main");
              },
              child: Container(width: 300 , height:  200, color: Colors.green,),
            ),
        ),
        ContextMenuOverlay(
          blockPointer: false,
          getTag: "main",
          /// Make a custom background
          cardBuilder: (_, children) => Container(color: Colors.purple.shade100, child: Column(children: children)),

          /// Make custom buttons
          buttonBuilder: (_, config, [__]) => TextButton(
            onPressed: config.onPressed,
            child: SizedBox(width: double.infinity, child: Text(config.label)),
          ),
          child: Container(),
        ),
      ],
    );

    return ContextMenuOverlay(
      /// Make a custom background
      cardBuilder: (_, children) => Container(color: Colors.purple.shade100, child: Column(children: children)),

      /// Make custom buttons
      buttonBuilder: (_, config, [__]) => TextButton(
        onPressed: config.onPressed,
        child: SizedBox(width: double.infinity, child: Text(config.label)),
      ),
      child: Container(color: Colors.blue.shade200, child: const TestContent(title: "Custom Menus")),
    );
  }
}

class TestContent extends StatelessWidget {
  const TestContent({Key? key, required this.title}) : super(key: key);
  final String title;
  final String _testImageUrl =
      "https://images.unsplash.com/photo-1590005354167-6da97870c757?auto=format&fit=crop&w=100&q=80";

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.transparent,
      child: Column(
        children: [

          /// Example menu for non-selectable text
          ContextMenuRegion(
            contextMenu: TextContextMenu(data: title),
            child: Text(title, style: const TextStyle(fontSize: 32)),
          ),

          /// Example hyperlink menu
          ContextMenuRegion(
            contextMenu: const LinkContextMenu(url: 'http://flutter.dev'),
            child: TextButton(onPressed: () {}, child: const Text("http://flutter.dev")),
          ),

          /// Custom Context Menu for an Image
          ContextMenuRegion(
            contextMenu: GenericContextMenu(
              buttonConfigs: [
                ContextMenuButtonConfig(
                  "View image in browser",
                  onPressed: () => launch(_testImageUrl),
                ),
                ContextMenuButtonConfig(
                  "Copy image path",
                  onPressed: () => Clipboard.setData(ClipboardData(text: _testImageUrl)),
                )
              ],
            ),
            child: Image.network(_testImageUrl),
          ),

          GestureDetector(
            onSecondaryTapUp: (e){
              context.contextMenuOverlay.show(ElevatedButton(onPressed: (){
                ContextMenuOverlay.of(context).hide();
              }, child: Text("test")));
            },
            child: Container(
              width: 300,
              height: 100,
              color: Colors.redAccent,
            ),
          ),

        ],
      ),
    );
  }
}
