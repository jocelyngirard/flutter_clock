class Characters {
  List<List<bool>> zero = _to2dArray("""0000000
0111110
0100010
0100010
0100010
0100010
0100010
0111110
0000000
""");

  List<List<bool>> one = _to2dArray("""0000000
0001000
0001000
0001000
0001000
0001000
0001000
0001000
0000000
""");

  List<List<bool>> two = _to2dArray("""0000000
0111110
0000010
0000010
0111110
0100000
0100000
0111110
0000000
""");

  List<List<bool>> three = _to2dArray("""0000000
0111110
0000010
0000010
0011110
0000010
0000010
0111110
0000000
""");

  List<List<bool>> four = _to2dArray("""0000000
0100000
0100010
0100010
0111110
0000010
0000010
0000010
0000000
""");

  List<List<bool>> five = _to2dArray("""0000000
0111110
0100000
0100000
0111110
0000010
0000010
0111110
0000000
""");

  List<List<bool>> six = _to2dArray("""0000000
0100000
0100000
0100000
0111110
0100010
0100010
0111110
0000000
""");

  List<List<bool>> seven = _to2dArray("""0000000
0111110
0000010
0000010
0000010
0000010
0000010
0000010
0000000
""");

  List<List<bool>> eight = _to2dArray("""0000000
0111110
0100010
0100010
0111110
0100010
0100010
0111110
0000000
""");

  List<List<bool>> nine = _to2dArray("""0000000
0111110
0100010
0100010
0111110
0000010
0000010
0000010
0000000
""");

  static List<List<bool>> _to2dArray(String data) => data.split("\n").map((line) => List.from(line.runes.map((rune) => rune.toString() == '1' ? true : false)));

  static final Characters instance = Characters._init();

  Characters._init();
}
