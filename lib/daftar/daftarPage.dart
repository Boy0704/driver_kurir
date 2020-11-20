import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../secrets.dart';
import '../helper.dart';
import '../login/LoginPage.dart';

class WizardFormBloc extends FormBloc<String, String> {
  final namaLengkap = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  final username = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  final noTelp = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.email,
    ],
  );

  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
      FieldBlocValidators.passwordMin6Chars,
    ],
  );

  final jenisKendaraan = SelectFieldBloc(
    items: ['Motor', 'Mobil'],
  );

  final noPlat = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  final alamat = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  final firstName = TextFieldBloc();

  final lastName = TextFieldBloc();

  final gender = SelectFieldBloc(
    items: ['Male', 'Female'],
  );

  final birthDate = InputFieldBloc<DateTime, Object>(
    validators: [FieldBlocValidators.required],
  );

  final github = TextFieldBloc();

  final twitter = TextFieldBloc();

  final facebook = TextFieldBloc();

  WizardFormBloc() {
    addFieldBlocs(
      step: 0,
      fieldBlocs: [username, namaLengkap, email, password],
    );
    addFieldBlocs(
      step: 1,
      fieldBlocs: [jenisKendaraan, noPlat, alamat],
    );
  }

  bool _cekUsernameSama = true;

  @override
  void onSubmitting() async {
    if (state.currentStep == 0) {
      await Future.delayed(Duration(milliseconds: 500));

      //cek username
      final response =
          await http.post(Secrets.BASE_URL + "cek_username_driver", body: {
        "username": username.value.toString(),
      });
      final data = jsonDecode(response.body);

      print("hasil nya : $data");

      String value = data['status'];

      if (value == "0") {
        _cekUsernameSama = true;
      } else {
        _cekUsernameSama = false;
      }

      if (_cekUsernameSama) {
        username.addFieldError('No Telp sudah ada !');
        _cekUsernameSama = false;
        emitFailure(failureResponse: 'No Telp Sudah ada!');
      } else {
        emitSuccess();
      }
    } else if (state.currentStep == 1) {
      //cek proses simpan
      final response =
          await http.post(Secrets.BASE_URL + "daftar_driver", body: {
        "nama": namaLengkap.value.toString(),
        "username": username.value.toString(),
        "no_telp": noTelp.value.toString(),
        "password": password.value.toString(),
        "email": email.value.toString(),
        "jenis_kendaraan": jenisKendaraan.value.toString(),
        "no_plat": noPlat.value.toString(),
        "alamat": alamat.value.toString(),
      });
      final data = jsonDecode(response.body);

      print("hasil nya : $data");

      String value = data['status'];

      if (value == "1") {
        emitSuccess();
      } else {
        emitFailure(failureResponse: 'Ada kesalahan server!');
      }
    } else if (state.currentStep == 2) {
      await Future.delayed(Duration(milliseconds: 500));

      emitSuccess();
    }
  }
}

class DaftarPage extends StatefulWidget {
  @override
  _DaftarPageState createState() => _DaftarPageState();
}

class _DaftarPageState extends State<DaftarPage> {
  final Helper helper = new Helper();
  var _type = StepperType.horizontal;

  void _toggleType() {
    setState(() {
      if (_type == StepperType.horizontal) {
        _type = StepperType.vertical;
      } else {
        _type = StepperType.horizontal;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WizardFormBloc(),
      child: Builder(
        builder: (context) {
          return Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            child: Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                backgroundColor: Colors.yellow,
                title: new Text(
                  "Pendaftaran Driver",
                  style: TextStyle(color: Colors.black),
                ),
                actions: <Widget>[
                  IconButton(
                      icon: Icon(_type == StepperType.horizontal
                          ? Icons.swap_vert
                          : Icons.swap_horiz),
                      onPressed: _toggleType)
                ],
              ),
              body: SafeArea(
                child: FormBlocListener<WizardFormBloc, String, String>(
                  onSubmitting: (context, state) => LoadingDialog.show(context),
                  onSuccess: (context, state) {
                    LoadingDialog.hide(context);

                    if (state.stepCompleted == state.lastStep) {
                      helper.alertLog(
                          "Pendaftaran Berhasil, silahkan menunggu konfirmasi admin, untuk login");
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (_) => LoginPage()));
                    }
                  },
                  onFailure: (context, state) {
                    LoadingDialog.hide(context);
                  },
                  child: StepperFormBlocBuilder<WizardFormBloc>(
                    type: _type,
                    physics: ClampingScrollPhysics(),
                    stepsBuilder: (formBloc) {
                      return [
                        _accountStep(formBloc),
                        _personalStep(formBloc),
                      ];
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  FormBlocStep _accountStep(WizardFormBloc wizardFormBloc) {
    return FormBlocStep(
      title: Text('Account'),
      content: Column(
        children: <Widget>[
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.username,
            keyboardType: TextInputType.emailAddress,
            enableOnlyWhenFormBlocCanSubmit: true,
            decoration: InputDecoration(
              labelText: 'No Telp Aktif',
              prefixIcon: Icon(Icons.verified_user),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.namaLengkap,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Nama Lengkap',
              prefixIcon: Icon(Icons.person),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.email,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.password,
            keyboardType: TextInputType.emailAddress,
            suffixButton: SuffixButton.obscureText,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
          ),
        ],
      ),
    );
  }

  FormBlocStep _personalStep(WizardFormBloc wizardFormBloc) {
    return FormBlocStep(
      title: Text('Data Kendaraan'),
      content: Column(
        children: <Widget>[
          RadioButtonGroupFieldBlocBuilder<String>(
            selectFieldBloc: wizardFormBloc.jenisKendaraan,
            itemBuilder: (context, value) => value,
            decoration: InputDecoration(
              labelText: 'Jenis Kendaraan',
              prefixIcon: SizedBox(),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.noPlat,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'No Plat',
              prefixIcon: Icon(Icons.format_list_numbered),
            ),
          ),
          TextFieldBlocBuilder(
            textFieldBloc: wizardFormBloc.alamat,
            keyboardType: TextInputType.text,
            maxLines: 5,
            decoration: InputDecoration(
              labelText: 'Alamat',
              prefixIcon: Icon(Icons.place),
            ),
          ),
        ],
      ),
    );
  }
}

class LoadingDialog extends StatelessWidget {
  static void show(BuildContext context, {Key key}) => showDialog<void>(
        context: context,
        useRootNavigator: false,
        barrierDismissible: false,
        builder: (_) => LoadingDialog(key: key),
      ).then((_) => FocusScope.of(context).requestFocus(FocusNode()));

  static void hide(BuildContext context) => Navigator.pop(context);

  LoadingDialog({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Center(
        child: Card(
          child: Container(
            width: 80,
            height: 80,
            padding: EdgeInsets.all(12.0),
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

class SuccessScreen extends StatelessWidget {
  SuccessScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(Icons.tag_faces, size: 100),
            SizedBox(height: 10),
            Text(
              'Success',
              style: TextStyle(fontSize: 54, color: Colors.black),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            RaisedButton.icon(
              onPressed: () => Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => DaftarPage())),
              icon: Icon(Icons.replay),
              label: Text('AGAIN'),
            ),
          ],
        ),
      ),
    );
  }
}
