import 'package:baswara_app/core/color_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class JenisSampahWidget extends StatefulWidget {
  const JenisSampahWidget({super.key});

  @override
  State<JenisSampahWidget> createState() => _JenisSampahWidgetState();
}

class _JenisSampahWidgetState extends State<JenisSampahWidget> {
  ValueNotifier<List<int>> filterItem = ValueNotifier([]);

  @override
  void dispose() {
    // TODO: implement dispose
    filterItem.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.only(top: 15.0, left: 16, right: 16),
          child: Column(
            children: [
              ValueListenableBuilder(
                  valueListenable: filterItem,
                  builder: (context, value, _) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              if (value.contains(0)) {
                                filterItem.value = List.from(value)..remove(0);
                              } else {
                                filterItem.value = List.from(value)..add(0);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              width: 82,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: value.contains(0)
                                    ? null
                                    : Border.all(color: ColorValue.primary),
                                color: value.contains(0)
                                    ? ColorValue.primary
                                    : Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (value.contains(0))
                                    const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "semua",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: value.contains(0)
                                          ? Colors.white
                                          : ColorValue.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              if (value.contains(1)) {
                                filterItem.value = List.from(value)..remove(1);
                              } else {
                                filterItem.value = List.from(value)..add(1);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              width: 82,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: value.contains(1)
                                    ? null
                                    : Border.all(color: ColorValue.primary),
                                color: value.contains(1)
                                    ? ColorValue.primary
                                    : Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (value.contains(1))
                                    const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Plastik",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: value.contains(1)
                                          ? Colors.white
                                          : ColorValue.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              if (value.contains(2)) {
                                filterItem.value = List.from(value)..remove(2);
                              } else {
                                filterItem.value = List.from(value)..add(2);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              width: 82,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: value.contains(2)
                                    ? null
                                    : Border.all(color: ColorValue.primary),
                                color: value.contains(2)
                                    ? ColorValue.primary
                                    : Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (value.contains(2))
                                    const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Kertas",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: value.contains(2)
                                          ? Colors.white
                                          : ColorValue.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              if (value.contains(3)) {
                                filterItem.value = List.from(value)..remove(3);
                              } else {
                                filterItem.value = List.from(value)..add(3);
                              }
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              width: 82,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: value.contains(3)
                                    ? null
                                    : Border.all(color: ColorValue.primary),
                                color: value.contains(3)
                                    ? ColorValue.primary
                                    : Colors.white,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (value.contains(3))
                                    const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 12,
                                    ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "Besi",
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: value.contains(3)
                                          ? Colors.white
                                          : ColorValue.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
              const SizedBox(
                height: 25,
              ),
              FocusScope(
                node: FocusScopeNode(),
                child: TextField(
                  style: GoogleFonts.poppins(fontSize: 16),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorValue.primary),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: ColorValue.primary),
                      ),
                      hintText: "Search...",
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 16, color: ColorValue.primary),
                      isDense: true,
                      contentPadding: EdgeInsets.all(10),
                      suffixIcon: Icon(
                        Icons.search,
                        size: 24,
                        color: ColorValue.primary,
                      )),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(5)),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: const BoxDecoration(
                          border: Border(
                            bottom: BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  "No",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                "Nama",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  "Aksi",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: 115,
                          itemBuilder: (c, index) => Container(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom:
                                    BorderSide(color: Colors.black, width: 1),
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text(
                                      "${1 + index}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 4,
                                  child: Text(
                                    "Plastik",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                      child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      SvgPicture.asset(
                                          "assets/icons/icon_pencil.svg"),
                                      SvgPicture.asset(
                                        "assets/icons/icon_trash.svg",
                                        color: Colors.red,
                                      )
                                    ],
                                  )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "Tambah Jenis Sampah",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
