// import 'dart:async';

// import 'package:chat_alpha_sept/cubits/index.dart';
// import 'package:chat_alpha_sept/utils/index.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:equatable/equatable.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//         systemNavigationBarColor: Colors.transparent));
//     return MultiBlocProvider(
//       providers: [
//         BlocProvider(
//           create: (_) => TestCubit(),
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: Style.dark,
//         home: const TestScreen(),
//       ),
//     );
//   }
// }

// class TestCubit extends Cubit<TestState> {
//   final TestService _testService = TestService();
//   late StreamSubscription<List<TestModel>> _streamSubscription;
//   TestCubit() : super(const TestState()) {
//     setStatus(Status.loading);
//     _streamSubscription = _testService.streamDummyData().listen((event) {
//       setTestModelList(event);
//     });
//     setStatus(Status.initial);
//   }

//   @override
//   Future<void> close() {
//     _streamSubscription.cancel();
//     return super.close();
//   }

//   void setStatus(Status status) => emit(state.copyWith(status: status));
//   void setError(String error) => emit(state.copyWith(error: error));
//   void setTestModelList(List<TestModel> testModelList) =>
//       emit(state.copyWith(testModelList: testModelList));

//   Status get status => state.status;
//   String get error => state.error;
//   List<TestModel> get testModelList => state.testModelList;
// }

// class TestState extends Equatable {
//   final Status status;
//   final String error;
//   final List<TestModel> testModelList;

//   const TestState({
//     this.status = Status.initial,
//     this.error = '',
//     this.testModelList = const [],
//   });

//   TestState copyWith({
//     Status? status,
//     String? error,
//     List<TestModel>? testModelList,
//   }) =>
//       TestState(
//         status: status ?? this.status,
//         error: error ?? this.error,
//         testModelList: testModelList ?? this.testModelList,
//       );

//   @override
//   List<Object?> get props => [status, error, testModelList];
// }

// class TestScreen extends StatelessWidget {
//   const TestScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<TestCubit, TestState>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         if (state.status == Status.loading) {
//           return const CircularProgressIndicator();
//         }
//         return const TestView();
//       },
//     );
//   }
// }

// class TestView extends StatelessWidget {
//   const TestView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<TestCubit, TestState>(
//       builder: (context, state) {
//         List<TestModel> book = state.testModelList;
//         return Scaffold(
//           body: ListView.builder(
//               itemCount: book.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   title: Text(book[index].name),
//                   subtitle: Text(book[index].genre),
//                 );
//               }),
//         );
//       },
//     );
//   }
// }

// class TestService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Stream<List<TestModel>> streamDummyData() {
//     return _firestore.collection('dummy').snapshots().map((snapshot) {
//       return snapshot.docs.map((doc) {
//         return TestModel(
//           doc['name'],
//           doc['genre'],
//         );
//       }).toList();
//     });
//   }
// }

// class TestModel extends Equatable {
//   final String name;
//   final String genre;

//   const TestModel(this.name, this.genre);
//   @override
//   List<Object?> get props => [name, genre];
// }
