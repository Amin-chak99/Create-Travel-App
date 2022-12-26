import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import 'package:snippet_coder_utils/list_helper.dart';
import 'package:voyage/page/ajout_modif_contact.page.dart';
import 'contact.service.dart';
import 'model/contact.model.dart';
import 'mydrawer.page.dart';
class ContactPage extends StatefulWidget {
ContactService contactService = new ContactService();
  @override
  State<ContactPage> createState() => _ContactState();
}

class _ContactState extends State<ContactPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MyDrawer(),
        appBar: AppBar(
          title: Text('contact'),
        ),
        body: Center(
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: FormHelper.submitButton("Ajout", (){
                  Navigator.push(context,
                      MaterialPageRoute(
                        builder: (context)=>AjoutModifContactPages(),
                  ),
                  ).then((value) {
                    setState(() {});
                  });
                },
                  borderRadius: 10,
                  btnColor: Colors.blue,
                  borderColor: Colors.blue,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              _fetchData(),
            ],
          )
        )
    );

  }

  _fetchData() {


    return FutureBuilder<List<Contact>>(
        future: widget.contactService.listeContacts(),
        builder: (BuildContext context, AsyncSnapshot<List<Contact>> contacts){
        if (contacts.hasData) return _buildDataTable(contacts.data!);
        return Center(
          child: CircularProgressIndicator(),
        );
        }

    );

  }
  _buildDataTable(List<Contact> listContacts){
    return Padding(
        padding: const EdgeInsets.all(8.0),
      child: ListUtils.buildDataTable(
        context,
        ["Nom","Telephone","Action"],
        ["nom","tel",""],
        false,
        0,
        listContacts,
          (Contact c){
          Navigator.push(context,
          MaterialPageRoute(builder: (context)=> AjoutModifContactPages(
            modifMode: true,
            contact: c,
          )),

          ).then((value) {setState(() {

          });});

          },
            (Contact c){
          return showDialog(context: context,
              builder: (BuildContext context){
                 return AlertDialog(title: const Text("Supprimer Contact"),
                   content: const Text("Etes vous de vouloir supprimer ce contact ?"),
                   actions: [
                     Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       children: [
                         FormHelper.submitButton("oui",
                             (){
                           widget.contactService.supprimerContact(c).then((value) {
                             setState(() {
                               Navigator.of(context).pop();
                             });
                           });
                             },
                           width: 100,
                           borderRadius: 5,
                           btnColor:  Colors.green,
                           borderColor: Colors.green,
                         ),
                         const SizedBox(
                           width: 20,
                         ),
                         FormHelper.submitButton("Nom",
                             () {
                           Navigator.of(context).pop();
                             },
                           width: 100,
                           borderRadius: 5,
                         )
                       ],
                     )
                   ],
                 );
              });


            },
        headingRowColor: Colors.orangeAccent,
        isScrollable: true,
      columnSpacing: 50,
      columnTextFontSize: 20,
      columnTextBold: false ,
      onSort: (columnIndex , columnName , asc){},




      ),
    );

  }



}