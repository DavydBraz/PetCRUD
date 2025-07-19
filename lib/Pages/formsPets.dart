import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_crud_dvd/classes/petClass.dart';
import 'package:pet_crud_dvd/classes/petCrudClass.dart';
import 'package:pet_crud_dvd/utils/genre.dart';
import 'package:pet_crud_dvd/utils/size.dart';

class Formspets extends StatefulWidget {
  const Formspets({super.key});

  @override
  State<Formspets> createState() => _FormspetsState();

}



class _FormspetsState extends State<Formspets> {
  TextEditingController nameController=TextEditingController();
  String namePet="";

  TextEditingController breedController=TextEditingController();
  String breedPet="";

  PetGenre petGenre=PetGenre.femea;
  PetSize petSize=PetSize.pequeno;

  TextEditingController ageController=TextEditingController();
  int agePet=0;  
  
  File? _image;
  final _picker=ImagePicker();

  pickImage()async{//metodo para pegar imagem
    final pickedFile=await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile!=null) {
      _image=File(pickedFile.path);
      setState(() {
        
      });
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    breedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pet"),),
      body: ListView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Card(
            color: Colors.amber,
            child: Container(
              width: 200,
              height: 700,
              child: ListView(children: [      
                SizedBox(//Mostra imagem se ela existir, se nao informa que nao possui
                  child: _image==null
                        ?SizedBox(
                          width: 250,
                          height: 250,
                          child: Center(child: Text("No Image Picked")))
                        :SizedBox(
                          width: 250,
                          height: 250,
                          child: Image.file(_image!)),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 160, vertical: 15),
                  child: FloatingActionButton(//Botao para pegar imagem
                    child: Icon(Icons.photo_library),
                    onPressed: (){//chama o metodo que lida com isso
                      pickImage();
                    }
                  ),
                ),      
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(label: Text("Nome do pet")),
                    controller: nameController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 250,
                        child: TextFormField(
                          decoration: InputDecoration(label: Text("Raça do animal")),
                          controller: breedController,
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.only(top: 24, left: 10),
                        child: DropdownButton(
                          value: petGenre,
                          icon: const Icon(Icons.menu),
                          style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                          underline: Container(
                            height: 2,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                          onChanged: (PetGenre? newValue) {
                            setState(() {
                              petGenre=newValue!;
                            });
                          },
                          items: const[
                            DropdownMenuItem(
                              value: PetGenre.femea,
                              child: Text("Fêmea"),
                            ),
                            DropdownMenuItem(
                              value: PetGenre.macho,
                              child: Text("Macho"),
                            ),
                          ],
                        ),
                      ),
                  ],                    
                    ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: 200,
                        child: TextFormField(
                          controller: ageController,
                          decoration: InputDecoration(
                            labelText: 'Idade',
                            //border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:25),
                      child: DropdownButton(
                      value: petSize,
                      icon: Icon(Icons.menu),
                      style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                      underline: Container(
                        height: 2,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      onChanged: (PetSize? newSize){
                        setState(() {
                          petSize=newSize!;
                        });
                      },
                      items: [                          
                        DropdownMenuItem(
                          value: PetSize.pequeno,
                          child: Text("Pequeno porte"),
                        ),
                        DropdownMenuItem(
                          value: PetSize.medio,
                          child: Text("Médio porte"),
                        ),
                        DropdownMenuItem(
                          value: PetSize.grande,
                          child: Text("Grande porte"),
                        ),
                      ]
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20, left: 250, right: 15),
                  child: FloatingActionButton(
                    backgroundColor: Colors.green,
                    child: Icon(Icons.save),
                    onPressed: (){
                      // Atualiza os valores com base nos controllers
                      namePet = nameController.text.trim();
                      breedPet = breedController.text.trim();
                      agePet = int.tryParse(ageController.text.trim()) ?? 0;
                      if (_image==null||namePet.isEmpty||breedPet.isEmpty||agePet==0) {
                        ScaffoldMessenger.of(context).showSnackBar(//mensagem avisando que precisa de um valor
                          SnackBar(content: Text("Todos os campos precisam ser preenchidos para salvar!"))
                        );
                      }else{
                        var pet=Pet(
                          size: petSize, 
                          name: namePet, 
                          breed: breedPet, 
                          image: _image, 
                          genre: petGenre, 
                          age: agePet);
                        PetCrudClass().createPet(pet);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Pet salvo com sucesso!")),
                        );
                        Navigator.pop(context);
                      }
                  }),
                )
              ]
              ),
            ),
          ),
        ],
      ),
    );
  }
}