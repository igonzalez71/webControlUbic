import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'ui/usm_viewmodel.dart';
import 'ui/ubuscar.dart';
import 'ui/uadd.dart';


//Future main() async {
//  await dotenv.load(fileName: "assets/dotenv");
//  runApp(const MyApp());
//}

main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const appTitle = 'Control Ubicaciones Semielaborado';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: appTitle,
      home: MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ViewModelBuilder<USMViewModel>.reactive(
      viewModelBuilder: () => USMViewModel(),
      onModelReady: (model) => model.init(),
      builder: (context, model, child) => Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 1000),
        child: Container(
             color: Colors.black,
             child: Padding(
             padding: EdgeInsets.all(20),
             child: Row(
             children: [
               const Text("Control Ubicaciones", style: TextStyle(color: Colors.white, fontSize: 18)),
               Expanded(
               child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                       InkWell(
                          onTap: () { model.initmenu(true);},
                              child: const Text(
                                    'Buscar',
                                     style: TextStyle(color: Colors.white, fontSize: 18),
                               ),
                       ),
                              SizedBox(width: screenSize.width / 20),
                        InkWell(
                          onTap: () { model.initmenu(false);},
                                child: const Text(
                                     'Añadir',
                                      style: TextStyle(color: Colors.white, fontSize: 18),
                                    ),
                            ),
                        ],
                ))],
              )))),

      body: SafeArea(child: LayoutBuilder(builder: (context, constraints) {
          return Column(children: [
          Padding(
            padding: EdgeInsets.only(
            top: 10, left: 20,
            ),
            child: Container(
                width: constraints.maxWidth * 0.90,
                height: 10,
              ),
          ),
          Padding(
            padding: EdgeInsets.only(
             left: 20,
            ),
            child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff337ab7),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0), topRight:  Radius.circular(12.0)),

                  ),
                  width: constraints.maxWidth * 0.90,
                  height: constraints.maxHeight * 0.1,
                    child: model.boolbuscar ? Center(child: const Text('Buscar', style: TextStyle(color: Colors.white, fontSize: 18))): Center(child: const Text('Añadir', style: TextStyle(color: Colors.white, fontSize: 18))),
                 ),
            ),
            Padding(
            padding: EdgeInsets.only(
            left: 20,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xffdff0d8),
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12.0), bottomRight:  Radius.circular(12.0)),
                border: Border.all(
                  color: Color(0xff337ab7),
                ),
              ),
              width: constraints.maxWidth * 0.90,
              height: constraints.maxHeight * 0.80,
                  child: model.boolbuscar ? Center(child: widgetUbuscar(model, context, screenSize.width, screenSize.height)): Center(child: widgetUAdd(model, context, screenSize.width, screenSize.height)),
              ),
            ),

           ]);
        })),
   ));
  }

}


