import 'package:flutter/material.dart';
import 'dart:async'; //3.1 Importa un timer
import 'package:rive/rive.dart'
    show
        Artboard,
        RiveAnimation,
        SMIBool,
        SMINumber,
        SMITrigger,
        StateMachineController;

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isObscured = true;

  StateMachineController? _controller;

  SMIBool? _isChecking;
  SMIBool? _isHandsUp;
  SMITrigger? _triggerSuccess;
  SMITrigger? _triggerFail;

  //2.1 Variable para el recorrido de los ojos
  SMINumber? _numLook;

  //1.1) craear variables para FocusNode
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();

  //3.2 Timaer para detener miradada al dejar de escribir
  Timer? _typingDebounce;

  //1.2) agregar listeners a los FocusNode en initState (oyentes/chismosos)
  @override
  void initState() {
    super.initState();

    _emailFocusNode.addListener(() {
      if (_emailFocusNode.hasFocus) {
        //verifica que no sea nulo
        if (_isHandsUp != null) {
          //Manos abajo en el email
          _isHandsUp?.change(false);
          //2.2) ojos mirando al frente
          _numLook?.value = 50.0;
        }
      }
    });

    _passwordFocusNode.addListener(() {
      //Manos arriba en password
      _isHandsUp?.change(_passwordFocusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(
                width: size.width,
                height: 200,
                child: RiveAnimation.asset(
                  'animated_login_bear.riv',
                  stateMachines: const ['Login Machine'],
                  onInit: (Artboard artboard) {
                    _controller = StateMachineController.fromArtboard(
                      artboard,
                      'Login Machine',
                    );

                    if (_controller == null) return;

                    artboard.addController(_controller!);

                    _isChecking =
                        _controller!.findSMI('isChecking') as SMIBool?;
                    _isHandsUp = _controller!.findSMI('isHandsUp') as SMIBool?;
                    _triggerSuccess =
                        _controller!.findSMI('trigSuccess') as SMITrigger?;
                    _triggerFail =
                        _controller!.findSMI('trigFail') as SMITrigger?;
                    //2.3 vincular numLook con el controlador
                    _numLook = _controller!.findSMI('numLook') as SMINumber?;
                  },
                ),
              ),

              const SizedBox(height: 10),

              //Campo de texto email
              TextField(
                //1.3) asignar el FocusNode al TextField
                focusNode: _emailFocusNode,
                onChanged: (value) {
                  if (_isHandsUp != null) {
                    //_isHandsUp!.value = false;
                    //_isChecking!.change(true);
                  }

                  if (_isChecking != null) {
                    _isChecking!.value = true;
                    //2.4 Implementar numLook
                    //Ajustes de límites de 0=100
                    //80 como medida de calibración
                    final look = (value.length / 80.0 * 100).clamp(
                      0,
                      100,
                    ); // clamp para limitar el rango de valores

                    _numLook?.value = look.toDouble();

                    //3.3 Reiniciar el timer cada vez que se escribe
                    //cancelar cualquier timer activo antes de iniciar uno nuevo
                    _typingDebounce?.cancel();
                    //crear nuevo timer
                    _typingDebounce = Timer(
                      const Duration(milliseconds: 800),
                      () {
                        //si se cierra la pantalla, quita el contador
                        if (!mounted) return;
                        //mirada neutra
                        _isChecking?.change(false);
                      },
                    );
                  }
                },
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              //Campo de texto password
              TextField(
                //1.3) asignar el FocusNode al TextField
                focusNode: _passwordFocusNode,
                onChanged: (value) {
                  if (_isChecking != null) {
                    //_isChecking!.value = false;
                  }

                  if (_isHandsUp != null) {
                    _isHandsUp!.value = true;
                  }
                }, // ✅ ESTA COMA FALTABA (línea 104)

                obscureText: _isObscured,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon: const Icon(Icons.lock),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isObscured ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscured = !_isObscured;
                      });
                    },
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //1.4 liberar memoria
  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _typingDebounce?.cancel();
    super.dispose();
  }
}
