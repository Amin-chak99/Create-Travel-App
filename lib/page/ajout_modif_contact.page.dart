import 'package:flutter/material.dart';
import 'package:snippet_coder_utils/FormHelper.dart';
import '../model/contact.model.dart';
import '../contact.service.dart';

class AjoutModifContactPages extends StatefulWidget {
   final Contact? contact;
   final bool modifMode;

  AjoutModifContactPages({this.contact, this.modifMode = false});
  @override
  State<AjoutModifContactPages> createState() => _AjoutModifContactPagesState();
}

class _AjoutModifContactPagesState extends State<AjoutModifContactPages> {
  GlobalKey<FormState> globalKey=GlobalKey<FormState>();
  late Contact? contact;
  late ContactService contactService;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.modifMode? 'Page Modifier Contact':'Page Ajouter Contact'),
      ),
      body:Form(
        key: globalKey,
        child: _formUI(),
      ),
      bottomNavigationBar: SizedBox(

        height: 100,

          child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            FormHelper.submitButton(
              widget.modifMode? "Modifier":"Ajouter", (){
              if(validateAndSave()){
                if (widget.modifMode){
                  contactService.modifierContact(contact!).then((value) {
                    Navigator.pop(context);
                  });
                }
                else
                contactService.ajouterContact(contact!).then((value) {
                  Navigator.pop(context);
                });
              }
            },
              borderRadius: 10,
              btnColor: Colors.green,
              borderColor: Colors.green,
            ),
              FormHelper.submitButton("Annuler", (){


          Navigator.pop(context);
        },
          borderRadius: 10,
          btnColor: Colors.grey,
          borderColor: Colors.grey,
        ),
          ],

        ),
      ),
    );
  }
  void initState(){
    super.initState();
    contactService=ContactService();
    contact=Contact(nom:"",tel: 1);
    if (widget.modifMode) contact=widget.contact! ;
  }
  _formUI(){
    return SingleChildScrollView(
      child: Padding(
        padding:const EdgeInsets.all(10),
        child: Column(
          children: [
            FormHelper.inputFieldWidgetWithLabel(
              context,
              "Nom",
              "Nom",
                  "",
                  (onValidate){
                if(onValidate.isEmpty){
                  return"* Required";
                }
                return null;
              },
                  (onSaved){
                contact!.nom= onSaved.toString().trim();
              },
              initialValue:widget.modifMode ? contact!.nom:"",
              showPrefixIcon: true,
              prefixIcon: const Icon(Icons.text_fields),
              borderRadius: 10,
              contentPadding: 15,
              fontSize: 14,
              labelFontSize: 14,
              paddingLeft: 0,
              paddingRight: 0,
              prefixIconPaddingLeft: 10,
            ),
            FormHelper.inputFieldWidgetWithLabel(context, "tel", "Téléphone", "", (onValidate){
              if(onValidate.isEmpty){
                return ('* required');
              }
              return null;
            }, (onSaved){
              contact!.tel=int.parse(onSaved.toString().trim());
            },
                initialValue:widget.modifMode ? contact!.tel.toString():"",
                showPrefixIcon: true,
                prefixIcon: Icon(Icons.numbers),
                borderRadius: 10,
                contentPadding: 15,
                fontSize: 14,
                labelFontSize: 14,
                paddingRight: 0,
                paddingLeft: 0,
                prefixIconPaddingLeft: 10,
                isNumeric: true
            ),
          ],
        ),
      ),
    );
  }
  bool validateAndSave(){
    final form=globalKey.currentState;
    if(form!.validate()){
      form.save();
      return true;
    }
    return false;

  }
}