import 'package:flutter/material.dart';
import 'package:pet_crud_dvd/Pages/formsPets.dart';
import 'package:pet_crud_dvd/classes/petClass.dart';
import 'package:pet_crud_dvd/classes/petCrudClass.dart';

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
              label: Text('Adicionar'),
            ),
          ),
        ),
        SizedBox(
          width: 200,
          height: 550,
          child: pets.isEmpty
                  ?Center(child: Text("Nenhum pet cadastrado."))
                  :ListView.builder(
            itemCount: pets.length, 
            itemBuilder: (context, index){
              final pet=pets[index];
              return Card(
                color: Colors.blue,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Nome: ${pet.name}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                          Text("Idade: ${pet.age}"),
                          Text("Raça: ${pet.breed}"),
                          //Aqui vou poder colocar o botao de carinho e o editar, que dai redirecionara para a pagina do forms, juntamente enviando já os dados
                          //preenchidos.
                          //Além disso, poder colocar um botao de delete para remover o animal, disso poderia colocar tipo se clicar e segurar para aparecer
                          //ou algo do tipo também.
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