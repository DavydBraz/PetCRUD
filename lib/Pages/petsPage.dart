import 'package:flutter/material.dart';
import 'package:pet_crud_dvd/Pages/formsPets.dart';
import 'package:pet_crud_dvd/classes/petClass.dart';
import 'package:pet_crud_dvd/classes/petCrudClass.dart';
import 'package:pet_crud_dvd/utils/genre.dart';
import 'package:pet_crud_dvd/utils/size.dart';
import 'package:pet_crud_dvd/utils/translate.dart';

class PetsPage extends StatefulWidget {
  const PetsPage({super.key});

  @override
  State<PetsPage> createState() => _PetsPageState();
}

class _PetsPageState extends State<PetsPage> {
  List<Pet> pets=[];

  @override
  void initState() {
    // TODO: implement initState
    pets.addAll(PetCrudClass().getAllPets());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,//Faz com só utilize o tamanho que precisa, em vez de tomar a tela inteira
      physics: NeverScrollableScrollPhysics(),//Impede rolagem
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: FloatingActionButton.extended(//para poder colocar o texto e o botao
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Formspets()),
                ).then((_) {
                  // Atualiza a lista ao voltar da tela de formulário
                  setState(() {
                    pets = PetCrudClass().getAllPets();
                  });
                });
              },
              icon: Icon(Icons.add),
              label: Text(translate('add')),
            ),
          ),
        ),
        SizedBox(
          width: 200,
          height: 550,
          child: pets.isEmpty
                  ?Center(child: Text(translate('no_pets')))
                  :ListView.builder(
            itemCount: pets.length, 
            itemBuilder: (context, index){
              final pet=pets[index];
              return Card(
                color: const Color.fromARGB(255, 6, 65, 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //Imagem de um lado
                    pet.image!=null
                    ?Image.file(
                      pet.image!,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,//tipo dde preenchimento para ajustar o tamanho da imagem
                    )
                    :Icon(Icons.pets),
                    SizedBox(width: 16),//dar um espaco entre eles
                  
                    //Colocar os texto do outro
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${translate('name')} ${pet.name}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color:  Theme.of(context).textTheme.bodyLarge!.color),),
                                Text("${translate('age')} ${pet.age}", style: TextStyle(color:  Theme.of(context).textTheme.bodyLarge!.color),),
                                Text("${translate('breed')} ${pet.breed}", style: TextStyle(color:  Theme.of(context).textTheme.bodyLarge!.color),),
                                Text(pet.genre==PetGenre.macho?translate('gender_male'):translate('gender_female'), style: TextStyle(color:  Theme.of(context).textTheme.bodyLarge!.color),),
                                Text(pet.size==PetSize.pequeno?translate('size_small'):(pet.size==PetSize.medio?translate('size_medium'):translate('size_large')), style: TextStyle(color:  Theme.of(context).textTheme.bodyLarge!.color),),
                                //Aqui vou poder colocar o botao de carinho e o editar, que dai redirecionara para a pagina do forms, juntamente enviando já os dados
                                //preenchidos.
                                //Além disso, poder colocar um botao de delete para remover o animal, disso poderia colocar tipo se clicar e segurar para aparecer
                                //ou algo do tipo também.
                              ],
                            ),
                          ),
                            Row(//para conseguir dimensionar da forma que eu queria, colocando esse grupo no recanto com apenas uma pequena separação
                              children: [
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: IconButton(
                                    color: Colors.red,
                                    onPressed: () {
                                      setState(() {
                                        PetCrudClass().deletePet(pet.name);
                                        pets=PetCrudClass().getAllPets();
                                      });
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ),
                                SizedBox(width: 8), // Espaço entre os ícones
                                SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: IconButton(
                                    color: Colors.blue,
                                    onPressed: () {
                                      Navigator.push(
                                        context, 
                                        MaterialPageRoute(
                                          builder: (context)=>Formspets(pet: pet)
                                        ),
                                      ).then((_){
                                        setState(() {
                                          pets=PetCrudClass().getAllPets();
                                        });
                                      });
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      )
                    )
                  ],
                ),
              );
              }),
        ),
      ],
    );
  }
}