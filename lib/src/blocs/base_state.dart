import 'package:flutter/material.dart';

import '../localizations/localizations.dart';
import '../utilities/utilities.dart';
import 'blocs.dart';

abstract class BaseState<T extends StatefulWidget, B extends BaseBloc> extends State<T> with WidgetsBindingObserver {
  final spinKitSize = 20.0;

  B get bloc;

  AppLocalizations localizations;

  bool get isContentLayout => false;

  bool isFirstInit = true;

  bool _isDispose = false;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();

    bloc?.waitingStream?.listen(_waitingListener);
    bloc?.listenerStream?.listen(blocListener);
    bloc?.restStatusCodeStream?.listen(_statusCodeListener);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    localizations ??= AppLocalizations.of(context);
    if (isFirstInit) {
      if (mounted) {
        final args = ModalRoute.of(context)?.settings?.arguments;
        onNavigateAsync(args);
      }

      loadData();
      isFirstInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _body;
    _body = (bloc != null)
        ? StreamBuilder<bool>(
            stream: bloc.loadingStream,
            builder: (context, snapShot) {
              if (snapShot?.data == true) {
                return buildLoading(context);
              }
              return buildContent(context);
            },
          )
        : buildContent(context);

    return isContentLayout == true
        ? _body
        : GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: Scaffold(
              appBar: buildAppBar(context),
              body: SafeArea(child: _body),
              drawer: buildDrawer(context),
              floatingActionButton: buildFloatButton(context),
            ),
          );
  }

  Widget buildContent(BuildContext context) => Container();

  Widget buildAppBar(BuildContext context) => null;

  Widget buildLoading(BuildContext context) => LoadingWidget();

  Widget buildDrawer(BuildContext context) => null;

  Widget buildFloatButton(BuildContext context) => null;

  void onNavigateAsync(Object payload) {}

  void loadData() {}

  void _waitingListener(bool loading) {
    if (loading) {
      LoadingDialog.show(context);
    } else {
      LoadingDialog.close(context);
    }
  }

  void blocListener(dynamic state) {}

  void onUnauthorizedException() {}

  void onForbiddenException() {}

  void onNotFoundException() {}

  void onOtherStatusCodeException(int statusCode) {}

  void _statusCodeListener(int statusCode) {
    switch (statusCode) {
      case 401:
        onUnauthorizedException();
        break;
      case 403:
        onForbiddenException();
        break;
      case 404:
        onNotFoundException();
        break;
      default:
        onOtherStatusCodeException(statusCode);
        break;
    }
  }

  @override
  void dispose() {
    Log.d('$widget onDispose');
    bloc?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    _isDispose = true;
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && !isFirstInit) {
      onResume();
    } else if (state == AppLifecycleState.paused) {
      onPause();
    } else if (state == AppLifecycleState.detached) {
      onDetach();
    } else if (state == AppLifecycleState.inactive) {
      onInactive();
    }
  }

  @mustCallSuper
  void onResume() {
    if (!_isDispose) {
      Log.d('$widget onResume');
      bloc?.onResume();
    }
  }

  @mustCallSuper
  void onPause() {
    if (!_isDispose) {
      Log.d('$widget onPause');
      bloc?.onPause();
    }
  }

  @mustCallSuper
  void onDetach() {
    if (!_isDispose) {
      Log.d('$widget onDetach');
      bloc?.onDetach();
    }
  }

  @mustCallSuper
  void onInactive() {
    if (!_isDispose) {
      Log.d('$widget onInactive');
      bloc?.onInactive();
    }
  }
}
