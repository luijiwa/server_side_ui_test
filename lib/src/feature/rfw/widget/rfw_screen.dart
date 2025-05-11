import 'package:flutter/material.dart';
import 'package:rfw/formats.dart';
import 'package:rfw/rfw.dart';

class RfwScreen extends StatefulWidget {
  const RfwScreen({super.key});

  @override
  State<RfwScreen> createState() => _RfwScreenState();
}

class _RfwScreenState extends State<RfwScreen> {
  final Runtime _runtime =
      Runtime()
        ..update(const LibraryName(<String>['core', 'widgets']), createCoreWidgets())
        ..update(const LibraryName(<String>['core', 'material']), createMaterialWidgets());
  final DynamicContent _data = DynamicContent();
  final ValueNotifier<bool> _ready = ValueNotifier<bool>(false);

  static const LibraryName _mainLib = LibraryName(<String>['main']);

  static const String _rfwText = '''
import core.widgets;
import core.material;



widget BannerWidget = Scaffold(
  appBar: AppBar(title: Text(text: "Banner Example")),
  body: Center(
    child: Stack(
   
      children: [
        Container(
          width: 300.0,
          height: 200.0,
          color: 0xFFFFFFFF,
        ),
        SizedBox(height: 20.0),
        Text(
          text: "Welcome to the Banner!",
          style: {
            fontSize: 24.0,
            fontWeight: "bold",
            color: 0xFF000000,
          },
        ),
        
      ],
    ),
  ),
);
''';

  @override
  void initState() {
    super.initState();
    // _data.update('items', [
    //   {'label': 'Элемент 1', 'expanded': false, 'color': 0xFF2196F3},
    //   {'label': 'Элемент 2', 'expanded': false, 'color': 0xFFFF5722},
    //   {'label': 'Элемент 3', 'expanded': false, 'color': 0xFF4CAF50},
    // ]);

    _loadLocalWidgets();
  }

  void _loadLocalWidgets() {
    try {
      final lib = parseLibraryFile(_rfwText);
      _runtime.update(_mainLib, lib);
      _ready.value = true;
    } catch (e, stack) {
      print('Ошибка при парсинге: $e');
      FlutterError.reportError(FlutterErrorDetails(exception: e, stack: stack));
      rethrow;
    }
  }

  @override
  void dispose() {
    _ready.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<bool>(
        valueListenable: _ready,
        builder: (context, ready, _) {
          if (!ready) {
            return const Center(child: Text('Загрузка...'));
          }
          return RemoteWidget(
            runtime: _runtime,
            data: _data,
            widget: const FullyQualifiedWidgetName(_mainLib, 'BannerWidget'),
            onEvent: (name, args) {},
          );
        },
      ),
    );
  }
}
