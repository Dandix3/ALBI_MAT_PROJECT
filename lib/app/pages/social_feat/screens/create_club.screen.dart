import 'package:albi_hry/app/pages/auth/widgets/text_field_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:provider/provider.dart';

import '../providers/club.provider.dart';

class CreateClubScreen extends StatelessWidget {
  CreateClubScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _addressController = TextEditingController();
  final _cityController = TextEditingController();
  final _postalCodeController = TextEditingController();
  final _latitudeController = TextEditingController();
  final _longitudeController = TextEditingController();

  Future<GeoPoint?> selectLocation(context) async {
    return await showSimplePickerLocation(
      context: context,
      isDismissible: true,
      titleWidget: const Padding(
        padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
        child: Text("Přesná lokace"),
      ),
      textConfirmPicker: "Vybrat",
      textCancelPicker: "Zrušit",
      contentPadding: EdgeInsets.only(bottom: 10),
      initCurrentUserPosition: true,
      initZoom: 15,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    final clubProvider = Provider.of<ClubProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Nová skupina', style: theme.textTheme.headline4),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              TextFieldForm(
                controller: _nameController,
                label: 'Název skupiny',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Název skupiny je povinný';
                  }
                  return null;
                },
                obscureText: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              TextFieldForm(
                controller: _descriptionController,
                label: 'Popis skupiny',
                validator: (value) {
                  return null;
                },
                obscureText: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              TextFieldForm(
                controller: _addressController,
                label: 'Adresa',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Adresa je povinná';
                  }
                  return null;
                },
                obscureText: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              TextFieldForm(
                controller: _cityController,
                label: 'Město',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Město je povinné';
                  }
                  return null;
                },
                obscureText: false,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
              ),
              TextFieldForm(
                controller: _postalCodeController,
                label: 'PSČ',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'PSČ je povinné';
                  }
                  return null;
                },
                obscureText: false,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
              ),
              ElevatedButton(
                onPressed: () {
                  selectLocation(context).then((value) => {
                        _latitudeController.text = value!.latitude.toString(),
                        _longitudeController.text = value.longitude.toString()
                  });
                },
                child: Text('Urči přesnou polohu skupiny'),
              ),
              SizedBox(
                height: size.height * 0.1,
              ),
              Divider(
                color: theme.colorScheme.background,
                thickness: 2,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    clubProvider.createClub(
                      context: context,
                      name: _nameController.text,
                      description: _descriptionController.text,
                      address: _addressController.text,
                      city: _cityController.text,
                      postalCode: int.parse(_postalCodeController.text),
                      lat: double.parse(_latitudeController.text),
                      lng: double.parse(_longitudeController.text),
                    );
                  }
                },
                child: Text('Vytvořit skupinu'),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
