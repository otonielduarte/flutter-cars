import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cars/car/car.dart';
import 'package:cars/car/car_api.dart';
import 'package:cars/shared/event_bus.dart';
import 'package:cars/shared/services/api_response.dart';
import 'package:cars/shared/services/upload_api.dart';
import 'package:cars/shared/upload/upload_model.dart';
import 'package:cars/shared/util/toast.dart';
import 'package:cars/shared/widget/app_button.dart';
import 'package:cars/shared/widget/app_dialog.dart';
import 'package:cars/shared/widget/app_input_text.dart';
import 'package:cars/shared/widget/app_radio_button.dart';
import 'package:cars/shared/widget/app_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CarFormPage extends StatefulWidget {
  final Car? car;

  CarFormPage(this.car);

  @override
  State<StatefulWidget> createState() => _CarroFormPageState();
}

class _CarroFormPageState extends State<CarFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final tNome = TextEditingController();
  final tDesc = TextEditingController();
  final tTipo = TextEditingController();
  File? _file;

  int _radioIndex = 0;

  bool _showProgress = false;

  Car? get car => widget.car;

  // Add validate email function.
  _validateNome(String value) {
    if (value.isEmpty) {
      return 'Informe o nome do car.';
    }

    return null;
  }

  @override
  void initState() {
    super.initState();

    // Copia os dados do car para o form
    if (car != null) {
      tNome.text = car!.nome!;
      tDesc.text = car!.desc!;
      _radioIndex = getTipoInt(car!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _appBarTitle(),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: _form(),
      ),
    );
  }

  String _appBarTitle() {
    String title = 'Novo Carr';
    if (car != null) {
      title = car!.nome ?? '';
    }
    return title;
  }

  _form() {
    return Form(
      key: this._formKey,
      child: ListView(
        children: <Widget>[
          _headerFoto(),
          AppText(
            "Clique na imagem para tirar uma foto",
            fontSize: 16,
          ),
          Divider(),
          AppText("Tipo"),
          _radioTipo(),
          Divider(),
          AppInputText(
              controller: tNome,
              label: "Nome",
              hintText: "nome",
              validator: (value) => _validateNome(value)),
          AppInputText(
              controller: tDesc,
              label: "Description",
              hintText: "Description",
              validator: (value) => _validateNome(value)),
          AppButton(
            "Salvar",
            isLoading: _showProgress,
            onPressed: _onClickSalvar,
          ),
        ],
      ),
    );
  }

  _headerFoto() {
    return GestureDetector(
      onTap: () => showDialog(
          context: context,
          builder: (BuildContext dialigContext) => AppDialoag(
                "Select when you get a picture:",
                actions: [
                  TextButton(
                    child: Text('From galery'),
                    onPressed: () {
                      Navigator.pop(dialigContext);
                      _onImageButtonPressed(ImageSource.gallery);
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(dialigContext);
                      _onImageButtonPressed(ImageSource.camera);
                    },
                    child: Text('from camera'),
                  )
                ],
              )),
      child: _file != null
          ? Image.file(
              _file!,
              height: 150,
            )
          : car != null
              ? CachedNetworkImage(
                  imageUrl: car!.urlFoto ?? '',
                )
              : Image.asset(
                  "assets/images/camera.png",
                  height: 150,
                ),
    );
  }

  void _onImageButtonPressed(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().getImage(
        source: source,
      );

      if (pickedFile != null) {
        setState(() {
          _file = File(pickedFile.path);
        });
      }
    } catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext imagecontext) =>
              AppDialoag("Error on take picture"));
    }
  }

  _radioTipo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AppRadioButton(
          "Clássicos",
          0,
          (value) => _onClickTipo(value),
          _radioIndex,
        ),
        AppRadioButton(
          "Esportivos",
          1,
          (value) => _onClickTipo(value),
          _radioIndex,
        ),
        AppRadioButton(
          "Luxo",
          2,
          (value) => _onClickTipo(value),
          _radioIndex,
        )
      ],
    );
  }

  void _onClickTipo(int value) {
    setState(() {
      _radioIndex = value;
    });
  }

  getTipoInt(Car car) {
    switch (car.tipo) {
      case "classicos":
        return 0;
      case "esportivos":
        return 1;
      default:
        return 2;
    }
  }

  String _getTipo() {
    switch (_radioIndex) {
      case 0:
        return "classicos";
      case 1:
        return "esportivos";
      default:
        return "luxo";
    }
  }

  _onClickSalvar() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    Car c = car ?? Car();
    c.nome = tNome.text;
    c.desc = tDesc.text;
    c.tipo = _getTipo();

    setState(() => _showProgress = true);

    if (_file != null) {
      UploadModel uploaded = UploadModel.fromFile(_file!, 'image/jpg');
      final String response = await UploadApi().uploadImage(uploaded);
      c.urlFoto = response;
    }

    ApiResponse response;
    if (car == null) {
      response = await CarApi()
          .save(c)
          .whenComplete(() => setState(() => _showProgress = false));
    } else {
      response = await CarApi()
          .update(c)
          .whenComplete(() => setState(() => _showProgress = false));
    }

    if (response.ok) {
      showToast('Carro ${response.result.nome} salvo com sucesso!');
      EventBus.get(context).sendEvent(
        CarEvent(
          action: "new car",
          type: c.tipo!,
        ),
      );
      Navigator.pop(context);
    } else {
      showToast(response.msg);
    }
  }
}
