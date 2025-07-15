import 'package:app_bloc/app_bloc.dart';
import 'package:core/core.dart';
import 'package:feature_main/src/main/page/chat_list.dart';
import 'package:feature_main/src/main/widget/connection_widget.dart';
import 'package:feature_main/src/main/widget/i_drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:use_case/use_case.dart';

@RoutePage()
class MainScreen extends StatefulWidget implements AutoRouteWrapper {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GetFileUseCase>(
          create: (_) => UseCaseHelper.getFileUseCase(),
        ),
        RepositoryProvider<DownloadFileUseCase>(
          create: (_) => UseCaseHelper.downloadFileUseCase(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<MainChatsBloc>(
            create: (_) => AppBlocHelper.getMainChatsBloc(),
          ),
          BlocProvider<ConnectionCubit>(
            create: (_) => AppBlocHelper.getConnectionCubit(),
          ),
          BlocProvider<AvatarCubit>(
            create: (_) => AppBlocHelper.getAvatarCubit(),
          ),
          BlocProvider<MeCubit>(
            create: (_) => AppBlocHelper.getMeCubit(),
          ),
        ],
        child: this,
      ),
    );
  }
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const IDrawerWidget(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      drawerScrimColor: Colors.black.withOpacity(0.3),
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: (){
                Scaffold.of(context).openDrawer();
              },
              child: const Icon(
                CupertinoIcons.bars,
                size: 30,
              ),
            );
          }
        ),
        title: const ConnectionWidget(),
      ),
      body: GestureDetector(
        onHorizontalDragUpdate: (details){
          if (details.delta.dx > 5) {
            Scaffold.of(context).openDrawer();
          }
        },
          child: const ChatListPage()
      ),
    );
  }
}