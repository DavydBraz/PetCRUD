import 'package:flutter/material.dart';
import 'package:pet_crud_dvd/myapp.dart';
import 'package:pet_crud_dvd/utils/app_config.dart';
import 'package:pet_crud_dvd/utils/translate.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

//List<String> language=['Português', 'Inglês'];
class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        SizedBox(
        width: 200,
        height: 300,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(translate('settings'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                //mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(translate('dark_mode'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                  ),
                  SizedBox(width: 10,),
                  Switch(
                    value: darkMode, 
                    onChanged: (bool newValue){
                    setState(() {
                      darkMode=newValue;
                    });
                    //alem de alterar a variavel global acima, precisamos recarregar a pagina(ja que nao estamos utilizando um gerenciador de estado
                    //tipo o Provider (mais leve e simples), ValueNotifier + ValueListenableBuilder, Riverpod, GetX, etc):
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Myapp()),
                    );
                  }),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(translate('language'), style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                  ListTile(
                    title: Text(translate('pt')),
                    leading: Radio(
                      value: 'pt', 
                      groupValue: currentLanguageCode, 
                      onChanged: (newValue){
                      setState(() {
                        currentLanguageCode=newValue.toString();
                      });
                    }),
                  ),
                  ListTile(
                    title: Text(translate('en')),
                    leading: Radio(
                      value: 'en', 
                      groupValue: currentLanguageCode, 
                      onChanged: (newValue){
                      setState(() {
                        currentLanguageCode=newValue.toString();
                      });
                    }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ],
    );
  }
}