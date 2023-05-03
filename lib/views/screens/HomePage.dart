import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_flutter/controller/time_controller.dart';
import 'package:todo_app_flutter/controller/todo_helper.dart';
import 'package:todo_app_flutter/models/resources.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../../controller/theme_Controller.dart';
import '../../models/todo_class_converter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<TodoObject> allTodos = [];
  final pdf = pw.Document();

  makePdf() {
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Padding(
            padding: const pw.EdgeInsets.all(20),
            child: pw.Container(
              alignment: pw.Alignment.topCenter,
              height: double.infinity,
              width: double.infinity,
              color: PdfColors.white,
              child: pw.Column(
                  mainAxisAlignment: pw.MainAxisAlignment.center,
                  crossAxisAlignment: pw.CrossAxisAlignment.center,
                  children: [
                    pw.Row(children: [
                      pw.Container(
                          alignment: pw.Alignment.center,
                          width: 380,
                          height: 40,
                          decoration: pw.BoxDecoration(
                            border: pw.Border.all(
                              width: 2,
                              color: PdfColors.black,
                            ),
                          ),
                          child: pw.Padding(
                            padding: const pw.EdgeInsets.all(10),
                            child: pw.Text(
                              'Your TODOs',
                              style: pw.TextStyle(
                                  fontSize: 25, fontWeight: pw.FontWeight.bold),
                            ),
                          )),
                      pw.Container(
                        alignment: pw.Alignment.center,
                        width: 100,
                        height: 40,
                        decoration: pw.BoxDecoration(
                          border:
                              pw.Border.all(width: 2, color: PdfColors.black),
                        ),
                        child: pw.Text(
                          'Time',
                          style: pw.TextStyle(
                              fontSize: 25, fontWeight: pw.FontWeight.bold),
                        ),
                      ),
                    ]),
                    pw.Column(
                      mainAxisAlignment: pw.MainAxisAlignment.center,
                      crossAxisAlignment: pw.CrossAxisAlignment.center,
                      children: todos
                          .map(
                            (e) => pw.Row(
                              children: [
                                pw.Container(
                                    alignment: pw.Alignment.center,
                                    width: 380,
                                    height: 30,
                                    decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          width: 2, color: PdfColors.black),
                                    ),
                                    child: pw.Padding(
                                      padding:const pw.EdgeInsets.all(10),
                                      child: pw.Text(
                                        '${e.todo}',
                                        style: const pw.TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    )),
                                pw.Container(
                                  alignment: pw.Alignment.center,
                                  width: 100,
                                  height: 30,
                                  decoration: pw.BoxDecoration(
                                    border: pw.Border.all(
                                        width: 2, color: PdfColors.black),
                                  ),
                                  child: pw.Text(
                                    '${e.time}',
                                    style: const pw.TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                          .toList(),
                    ),
                  ]),
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    hello() {
      setState(() {
        allTodos = todos;
      });
    }

    ;
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.menu_rounded,
          size: 30,
        ),
        title: Text(
          'Todo App',
          style: GoogleFonts.alata(
            fontWeight: FontWeight.w900,
            fontSize: 40,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).changeTheme();
            },
            icon: const Icon(
              Icons.light_mode_rounded,
              size: 25,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: () async {
              setState(() {
                makePdf();
              });
              pdf.editPage(0, pw.Page(
                build: (context) {
                  return pw.Container(
                    alignment: pw.Alignment.center,
                    height: double.infinity,
                    width: double.infinity,
                    color: PdfColors.white,
                    child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                        children: [
                          pw.Row(children: [
                            pw.Container(
                              alignment: pw.Alignment.centerLeft,
                              width: 400,
                              height: 40,
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    width: 2, color: PdfColors.black),
                              ),
                              child: pw.Text(
                                'Your TODOs',
                                style: pw.TextStyle(
                                    fontSize: 25,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ),
                            pw.Container(
                              alignment: pw.Alignment.center,
                              width: 100,
                              height: 40,
                              decoration: pw.BoxDecoration(
                                border: pw.Border.all(
                                    width: 2, color: PdfColors.black),
                              ),
                              child: pw.Text(
                                'Time',
                                style: pw.TextStyle(
                                    fontSize: 25,
                                    fontWeight: pw.FontWeight.bold),
                              ),
                            ),
                          ]),
                          pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: todos
                                .map(
                                  (e) => pw.Row(
                                    children: [
                                      pw.Container(
                                        alignment: pw.Alignment.center,
                                        width: 400,
                                        height: 30,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 2, color: PdfColors.black),
                                        ),
                                        child: pw.Text(
                                          '${e.todo}',
                                          style: const pw.TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      pw.Container(
                                        alignment: pw.Alignment.center,
                                        width: 100,
                                        height: 30,
                                        decoration: pw.BoxDecoration(
                                          border: pw.Border.all(
                                              width: 2, color: PdfColors.black),
                                        ),
                                        child: pw.Text(
                                          '${e.time}',
                                          style: const pw.TextStyle(
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ]),
                  );
                },
              ));
              Uint8List data = await pdf.save();
              await Printing.layoutPdf(onLayout: (format) => data);
            },
            icon: const Icon(
              Icons.picture_as_pdf,
              size: 25,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              width: double.infinity,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 0.0),
                      child: SizedBox(
                        height: 50,
                        child: TextField(
                          onChanged: (val) {},
                          decoration: InputDecoration(
                            filled: true,
                            prefix: const SizedBox(
                              width: 10,
                            ),
                            hintText: 'Search',
                            suffixIcon: Icon(
                              Icons.search_rounded,
                              color: (Provider.of<ThemeProvider>(context)
                                          .themeModal
                                          .isDark ==
                                      false)
                                  ? Colors.grey.shade600
                                  : Colors.grey.shade200,
                              size: 26,
                            ),
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: (Provider.of<ThemeProvider>(context)
                                          .themeModal
                                          .isDark ==
                                      false)
                                  ? Colors.grey.shade600
                                  : Colors.grey.shade200,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                            fillColor: (Provider.of<ThemeProvider>(context)
                                        .themeModal
                                        .isDark ==
                                    false)
                                ? Colors.grey.shade200
                                : Colors.grey.shade700,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: const BorderSide(
                                color: Colors.transparent,
                                width: 0,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 38,
                    ),
                    Text(
                      'All ToDos',
                      style: GoogleFonts.vampiroOne(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 8,
            child: (allTodos.isEmpty)
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.note_add_rounded,
                          size: 230,
                          color: Colors.grey.shade300,
                        ),
                        Text(
                          'No Todo Exist...',
                          style: GoogleFonts.alata(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                          ),
                        ),
                      ],
                    ),
                  )
                : StatefulBuilder(
                    builder: (context, setState) {
                      print('update');
                      return ListView.builder(
                        itemCount: allTodos.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 4),
                            child: Card(
                              elevation: 4,
                              child: ListTile(
                                leading: Text(
                                  '${index + 1})',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                title: Text(
                                  allTodos[index].todo,
                                  style: GoogleFonts.alata(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 25,
                                  ),
                                ),
                                trailing: Text(
                                  allTodos[index].time,
                                  style: GoogleFonts.alata(
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: StatefulBuilder(
        builder: (context, setState) {
          return FloatingActionButton(
            onPressed: () {
              if (todos.isEmpty) {
                showModalBottomSheet(
                  elevation: 3,
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                      builder: (context, setState) {
                        return Container(
                          height: 320,
                          decoration: BoxDecoration(
                            color: (Provider.of<ThemeProvider>(context)
                                        .themeModal
                                        .isDark ==
                                    false)
                                ? Colors.white
                                : Colors.grey.shade700,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            ),
                          ),
                          child: Form(
                            key: formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Text(
                                    'Add Your Todo',
                                    style: GoogleFonts.alata(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30,
                                    ),
                                  ),
                                ),
                                const Divider(
                                  thickness: 2,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: TextFormField(
                                    onSaved: (val) {
                                      setState(() {
                                        todo = val!;
                                      });
                                    },
                                    validator: (val) {
                                      if (val!.isEmpty) {
                                        return 'Please enter your task';
                                      }
                                      return null;
                                    },
                                    controller: todoController,
                                    decoration: InputDecoration(
                                      labelText: 'Enter your Todo',
                                      filled: true,
                                      prefix: const SizedBox(
                                        width: 10,
                                      ),
                                      hintText: 'Enter TODOs...',
                                      suffixIcon: Icon(
                                        Icons.edit,
                                        color:
                                            (Provider.of<ThemeProvider>(context)
                                                        .themeModal
                                                        .isDark ==
                                                    false)
                                                ? Colors.grey.shade600
                                                : Colors.grey.shade200,
                                        size: 26,
                                      ),
                                      hintStyle: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        color:
                                            (Provider.of<ThemeProvider>(context)
                                                        .themeModal
                                                        .isDark ==
                                                    false)
                                                ? Colors.grey.shade600
                                                : Colors.grey.shade200,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 0,
                                        ),
                                      ),
                                      fillColor:
                                          (Provider.of<ThemeProvider>(context)
                                                      .themeModal
                                                      .isDark ==
                                                  false)
                                              ? Colors.grey.shade200
                                              : Colors.grey.shade600,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(40),
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    const Spacer(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        '${Provider.of<TimeController>(context).timeModal.time}:00 ${Provider.of<TimeController>(context).timeModal.timeNote}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Transform.rotate(
                                      angle: pi,
                                      child: Container(
                                        width: 0,
                                        height: 33,
                                        decoration: BoxDecoration(
                                          border: Border(
                                            left: BorderSide(
                                              width: 2,
                                              color:
                                                  (Provider.of<ThemeProvider>(
                                                                  context)
                                                              .themeModal
                                                              .isDark ==
                                                          false)
                                                      ? Colors.grey.shade400
                                                      : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 7,
                                    ),
                                    OutlinedButton(
                                      style: ButtonStyle(
                                        side: MaterialStateProperty.all(
                                          BorderSide(
                                            color: (Provider.of<ThemeProvider>(
                                                            context)
                                                        .themeModal
                                                        .isDark ==
                                                    false)
                                                ? Colors.grey.shade800
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (Provider.of<TimeController>(context,
                                                        listen: false)
                                                    .timeModal
                                                    .time ==
                                                8 &&
                                            Provider.of<TimeController>(context,
                                                        listen: false)
                                                    .timeModal
                                                    .timeNote ==
                                                'PM') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            const SnackBar(
                                              dismissDirection:
                                                  DismissDirection.down,
                                              duration: Duration(
                                                milliseconds: 600,
                                              ),
                                              margin: EdgeInsets.symmetric(
                                                vertical: 230,
                                                horizontal: 10,
                                              ),
                                              behavior:
                                                  SnackBarBehavior.floating,
                                              backgroundColor: Colors.red,
                                              content: Text(
                                                  "Time reached it's limit.."),
                                            ),
                                          );
                                        }
                                        Provider.of<TimeController>(context,
                                                listen: false)
                                            .increment();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(0.0),
                                        child: Text(
                                          'Skip Time',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                            color: (Provider.of<ThemeProvider>(
                                                            context)
                                                        .themeModal
                                                        .isDark ==
                                                    false)
                                                ? Colors.grey.shade700
                                                : Colors.grey.shade200,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Spacer(),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      OutlinedButton(
                                        style: ButtonStyle(
                                          side: MaterialStateProperty.all(
                                            BorderSide(
                                              color:
                                                  (Provider.of<ThemeProvider>(
                                                                  context)
                                                              .themeModal
                                                              .isDark ==
                                                          false)
                                                      ? Colors.grey.shade800
                                                      : Colors.white,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Navigator.pop(context);
                                          todoController.clear();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Text(
                                            'Cancel',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color:
                                                  (Provider.of<ThemeProvider>(
                                                                  context)
                                                              .themeModal
                                                              .isDark ==
                                                          false)
                                                      ? Colors.grey.shade700
                                                      : Colors.grey.shade200,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      StatefulBuilder(
                                        builder: (context, setState) {
                                          setState(() {});
                                          return ElevatedButton(
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                (Provider.of<ThemeProvider>(
                                                                context)
                                                            .themeModal
                                                            .isDark ==
                                                        false)
                                                    ? Colors.grey.shade300
                                                    : Colors.grey,
                                              ),
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  formKey.currentState!.save();
                                                  Map temporary = {
                                                    'time':
                                                        '${Provider.of<TimeController>(context, listen: false).timeModal.time}:00 ${Provider.of<TimeController>(context, listen: false).timeModal.timeNote}',
                                                    'todo': todo,
                                                  };
                                                  setState(() {
                                                    TodoHelper.todoHelper
                                                        .addToTodoList(
                                                            data: temporary);
                                                  });
                                                  Provider.of<TimeController>(
                                                          context,
                                                          listen: false)
                                                      .increment();
                                                  todoController.clear();
                                                  setState(() {
                                                    allTodos = todos;
                                                  });
                                                  Navigator.pop(context);
                                                }
                                              });
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              child: Text(
                                                'Save',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                  color:
                                                      (Provider.of<ThemeProvider>(
                                                                      context)
                                                                  .themeModal
                                                                  .isDark ==
                                                              false)
                                                          ? Colors.grey.shade700
                                                          : Colors
                                                              .grey.shade200,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              } else {
                if (todos.last.time == '7:00 PM') {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      dismissDirection: DismissDirection.down,
                      duration: Duration(
                        milliseconds: 600,
                      ),
                      margin: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 10,
                      ),
                      behavior: SnackBarBehavior.floating,
                      backgroundColor: Colors.red,
                      content: Text("Time reached it's limit.."),
                    ),
                  );
                } else {
                  showModalBottomSheet(
                    elevation: 3,
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return Container(
                            height: 320,
                            decoration: BoxDecoration(
                              color: (Provider.of<ThemeProvider>(context)
                                          .themeModal
                                          .isDark ==
                                      false)
                                  ? Colors.white
                                  : Colors.grey.shade700,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              ),
                            ),
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'Add Your Todo',
                                      style: GoogleFonts.alata(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30,
                                      ),
                                    ),
                                  ),
                                  const Divider(
                                    thickness: 2,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: TextFormField(
                                      onSaved: (val) {
                                        todo = val!;
                                      },
                                      validator: (val) {
                                        if (val!.isEmpty) {
                                          return 'Please enter your task';
                                        }
                                        return null;
                                      },
                                      controller: todoController,
                                      onChanged: (val) {},
                                      decoration: InputDecoration(
                                        labelText: 'Enter your Todo',
                                        filled: true,
                                        prefix: const SizedBox(
                                          width: 10,
                                        ),
                                        hintText: 'Enter TODOs...',
                                        suffixIcon: Icon(
                                          Icons.edit,
                                          color: (Provider.of<ThemeProvider>(
                                                          context)
                                                      .themeModal
                                                      .isDark ==
                                                  false)
                                              ? Colors.grey.shade600
                                              : Colors.grey.shade200,
                                          size: 26,
                                        ),
                                        hintStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                          color: (Provider.of<ThemeProvider>(
                                                          context)
                                                      .themeModal
                                                      .isDark ==
                                                  false)
                                              ? Colors.grey.shade600
                                              : Colors.grey.shade200,
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                            width: 0,
                                          ),
                                        ),
                                        fillColor:
                                            (Provider.of<ThemeProvider>(context)
                                                        .themeModal
                                                        .isDark ==
                                                    false)
                                                ? Colors.grey.shade200
                                                : Colors.grey.shade600,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          borderSide: const BorderSide(
                                            color: Colors.transparent,
                                            width: 0,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '${Provider.of<TimeController>(context).timeModal.time}:00 ${Provider.of<TimeController>(context).timeModal.timeNote}',
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Transform.rotate(
                                        angle: pi,
                                        child: Container(
                                          width: 0,
                                          height: 33,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              left: BorderSide(
                                                width: 2,
                                                color:
                                                    (Provider.of<ThemeProvider>(
                                                                    context)
                                                                .themeModal
                                                                .isDark ==
                                                            false)
                                                        ? Colors.grey.shade400
                                                        : Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 7,
                                      ),
                                      OutlinedButton(
                                        style: ButtonStyle(
                                          side: MaterialStateProperty.all(
                                            BorderSide(
                                              color:
                                                  (Provider.of<ThemeProvider>(
                                                                  context)
                                                              .themeModal
                                                              .isDark ==
                                                          false)
                                                      ? Colors.grey.shade800
                                                      : Colors.white,
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          if (Provider.of<TimeController>(
                                                          context,
                                                          listen: false)
                                                      .timeModal
                                                      .time ==
                                                  8 &&
                                              Provider.of<TimeController>(
                                                          context,
                                                          listen: false)
                                                      .timeModal
                                                      .timeNote ==
                                                  'PM') {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                dismissDirection:
                                                    DismissDirection.down,
                                                duration: Duration(
                                                  milliseconds: 600,
                                                ),
                                                margin: EdgeInsets.symmetric(
                                                  vertical: 230,
                                                  horizontal: 10,
                                                ),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                backgroundColor: Colors.red,
                                                content: Text(
                                                    "Time reached it's limit.."),
                                              ),
                                            );
                                          }
                                          Provider.of<TimeController>(context,
                                                  listen: false)
                                              .increment();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: Text(
                                            'Skip Time',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                              color:
                                                  (Provider.of<ThemeProvider>(
                                                                  context)
                                                              .themeModal
                                                              .isDark ==
                                                          false)
                                                      ? Colors.grey.shade700
                                                      : Colors.grey.shade200,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Spacer(),
                                        const SizedBox(
                                          width: 7,
                                        ),
                                        OutlinedButton(
                                          style: ButtonStyle(
                                            side: MaterialStateProperty.all(
                                              BorderSide(
                                                color:
                                                    (Provider.of<ThemeProvider>(
                                                                    context)
                                                                .themeModal
                                                                .isDark ==
                                                            false)
                                                        ? Colors.grey.shade800
                                                        : Colors.white,
                                              ),
                                            ),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            todoController.clear();
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Text(
                                              'Cancel',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color:
                                                    (Provider.of<ThemeProvider>(
                                                                    context)
                                                                .themeModal
                                                                .isDark ==
                                                            false)
                                                        ? Colors.grey.shade700
                                                        : Colors.grey.shade200,
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        StatefulBuilder(
                                          builder: (context, setState) {
                                            return ElevatedButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                  (Provider.of<ThemeProvider>(
                                                                  context)
                                                              .themeModal
                                                              .isDark ==
                                                          false)
                                                      ? Colors.grey.shade300
                                                      : Colors.grey,
                                                ),
                                              ),
                                              onPressed: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  formKey.currentState!.save();
                                                  Map temporary = {
                                                    'time':
                                                        '${Provider.of<TimeController>(context, listen: false).timeModal.time}:00 ${Provider.of<TimeController>(context, listen: false).timeModal.timeNote}',
                                                    'todo': todo,
                                                  };
                                                  TodoHelper.todoHelper
                                                      .addToTodoList(
                                                          data: temporary);
                                                  Provider.of<TimeController>(
                                                          context,
                                                          listen: false)
                                                      .increment();
                                                  setState(() {
                                                    hello();
                                                    todos;
                                                  });
                                                  hello();
                                                  todoController.clear();
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text(
                                                  'Save',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                    color:
                                                        (Provider.of<ThemeProvider>(
                                                                        context)
                                                                    .themeModal
                                                                    .isDark ==
                                                                false)
                                                            ? Colors
                                                                .grey.shade700
                                                            : Colors
                                                                .grey.shade200,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }
              }
            },
            child: const Icon(
              Icons.add,
              size: 30,
            ),
          );
        },
      ),
    );
  }
}
