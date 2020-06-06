import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

/// 一个数据库接口类：CmmpDb；
/// 数据类：JournalRecord,HabitRecord,MedicineRecord.

enum Htype {
  b, l, e
} // ><=
enum dbType {
  jour, habit, medi, phy_par
}

class JournalRecord {
  DateTime recordDate;
  String content;

  JournalRecord({this.recordDate,this.content});

  factory JournalRecord.fromJson(Map<String, dynamic> parseJson){
    return JournalRecord(
      content: parseJson['content'],
      recordDate: DateTime.parse(parseJson['recordDate'])
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'recordDate': this.recordDate.toString(),
      'content': this.content
    };
  }
}

class HabitRecord {
  DateTime recordDate;
  String description;
  int requirement;
  var htype;

  HabitRecord({this.recordDate,this.description, this.requirement, this.htype});

  factory HabitRecord.fromJson(Map<String, dynamic> parseJson){
    return HabitRecord(
      description: parseJson['description'],
      requirement: parseJson['requirement'],
      htype: parseJson['htype'],
      recordDate: DateTime.parse(parseJson['recordDate'])
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'recordDate': this.recordDate.toString(),
      'description': this.description,
      'requirement': this.requirement,
      'htype': this.htype
    };
  }
}

class MedicineRecord {
  DateTime recordDate;
  String medicine;
  String takeTime;

  MedicineRecord({this.recordDate, this.medicine, this.takeTime});

  factory MedicineRecord.fromJson(Map<String, dynamic> parseJson){
    return MedicineRecord(
      medicine: parseJson['medicine'],
      takeTime: parseJson['takeTime'],
      recordDate: DateTime.parse(parseJson['recordDate'])
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'recordDate': this.recordDate.toString(),
      'medicine': this.medicine,
      'takeTime': this.takeTime
    };
  }
}

class PpRecord {
  DateTime recordDate;
  int value;  
  var types = {
    'w':  0,  // weight
    'hr': 1,  // heart_rate
    'bs': 2,  // blood sugar
    'bp': 3   // blood_pressure
  };
  int type; // 指定数据类型
  var labels = [['nl'],['nl'],['nl','bb','ab','bl','al','bd','ad','bs'],['dp','sp']];
/*
label: 指定数据标签。
除bp外都允许标签: nl。即禁用标签。
bs允许标签：  bb, ab, bl, al, bd, ad, bs。对应七次血糖监测时间。
bp允许标签:  dp, sp。舒张压，收缩压。
*/
  String label;

  PpRecord._internal({this.recordDate,this.value,this.type,this.label});

  PpRecord({int value, int type, String label, DateTime recordDate}){
    this.value = value;
    this.type = [0, 1, 2, 3].contains(type) ? type: null;
    this.label = labels[type].contains(label) ? label : null;
    if(this.type == null || this.label == null) throw "Check your type and label.";
    this.recordDate = recordDate;
  }

  factory PpRecord.fromJson(Map<String, dynamic> parseJson){
    return PpRecord(
      value: parseJson['value'],
      type:  parseJson['type'],
      label: parseJson['label'],
      recordDate: DateTime.parse(parseJson['recordDate'])
    );
  }

  Map<String,dynamic> toJson(){
    return {
      'recordDate': this.recordDate.toString(),
      'value':      this.value,
      'type':       this.type,
      'label':      this.label
    };
  }
}

class CmmpDB{
  static final CmmpDB _instance = new CmmpDB.internal();
  factory CmmpDB() => _instance;

  static List<String> TableName = ['jour','habit','medi','phy_par'];
  static List<String> JrlField = ['recordDate','content'];
  static List<String> HabField = ['recordDate','description','requirement','htype'];
  static List<String> MedField = ['recordDate','medicine','take_time'];
  static List<String> PpField  = ['recordDate','value','type','label'];
  static List Field = [JrlField, HabField, MedField, PpField];
  // static Map<String, int> DataTypeRef={
  //   ''
  // }
  static Database _db; 

  CmmpDB.internal();

  // 获得数据库
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  // 创建数据库
  initDb() async{
    var databasesPath = await getDatabasesPath();
    String dbpath = path.join(databasesPath, 'cmmpdb.db');
    var db = await openDatabase(dbpath, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute('''
        CREATE TABLE ${TableName[0]}( 
          "rid" INTEGER PRIMARY KEY, 
          ${JrlField[0]} String, 
          ${JrlField[1]} TEXT)
        '''); // 创建journal表
    await db.execute('''
        CREATE TABLE ${TableName[1]}( 
          "rid" INTEGER PRIMARY KEY, 
          ${HabField[0]} String, 
          ${HabField[1]} TEXT,
          ${HabField[2]} TEXT,
          ${HabField[3]} INTEGER)
        '''); // 创建habit表
    await db.execute('''
        CREATE TABLE ${TableName[2]}( 
          "rid" INTEGER PRIMARY KEY, 
          ${MedField[0]} String, 
          ${MedField[1]} String,
          ${MedField[2]} String)
        '''); // 创建medicine表
    await db.execute('''
        CREATE TABLE ${TableName[3]}( 
          "rid" INTEGER PRIMARY KEY, 
          ${PpField[0]} String, 
          ${PpField[1]} INTEGER,
          ${PpField[2]} INTEGER,
          ${PpField[3]} String) 
        '''); // 创建phy_par表
  }

  // type: 0 jour, 1 habi, 2 medi, 3 phy_par
  Future<int> insertData(dynamic data, int type) async {
    var dbClient = await db;
    var result = await dbClient.insert(
      TableName[type], data.toJson()
    );
    print(result);
    return result;
  }

  Future<List> selectData({int limit, int offset, int type}) async {
    var dbClient = await db;
    var result = await dbClient.query(
      TableName[type],
      columns: Field[type],
      limit: limit,
      offset: offset,
    );
    List dataList = [];
    if (type == 0){    
      result.forEach((item) => dataList.cast<JournalRecord>().add(JournalRecord.fromJson(item)));
    } else if (type == 1){
      result.forEach((item) => dataList.cast<HabitRecord>().add(HabitRecord.fromJson(item)));
    } else if (type == 2){
      result.forEach((item) => dataList.cast<MedicineRecord>().add(MedicineRecord.fromJson(item)));
    } else if (type == 3){
      result.forEach((item) => dataList.cast<PpRecord>().add(PpRecord.fromJson(item)));
    }
    
    return dataList;
  }

// 调用有风险，慎用
  Future getData(int rid, int type ) async {
    var dbClient = await db;
    List<Map> result = await dbClient.query(
        TableName[type],
        columns: Field[type],
        where: '$rid = ?',
        whereArgs: [rid]
    );

    if (result.length > 0) {
      if (type == 0){
        return JournalRecord.fromJson(result.first);
      } else if (type == 1){
        return HabitRecord.fromJson(result.first);
      } else if (type == 2){
        return MedicineRecord.fromJson(result.first);
      } else if (type == 3){
        return PpRecord.fromJson(result.first);
      }
    }
    return null;
  }

  Future<int> getRecordCount(int type) async{
    var dbClient = await db;
    var i = await dbClient.rawQuery('SELECT COUNT(*) FROM ${TableName[type]}');
    var j = Sqflite.firstIntValue(i);
    return j;
  }

  // Future<int> updateVideo(Video video) async {
  //   var dbClient = await db;
  //   return await dbClient.update(tableVideo, video.toJson(),
  //       where: "$columnId = ?", whereArgs: [video.id]);
  // }

  // Future<int> deleteVideo(String images) async {
  //   var dbClient = await db;
  //   return await dbClient
  //       .delete(tableVideo, where: '$image = ?', whereArgs: [images]);
  // }

  // Future<int> getCount() async {
  //   var dbClient = await db;
  //   return Sqflite.firstIntValue(
  //       await dbClient.rawQuery('SELECT COUNT(*) FROM $tableVideo'));
  // }


  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

}
