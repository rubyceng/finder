import 'package:finder/models/book.model.dart';

class BookApi {
  static Future<List<Book>> list() async {
    // TODO 调用实际接口
    // final resp = await Api.get('/book/list');

    // TODO 目前先 Mock
    // return Book.fromJson(resp.data);

    await Future.delayed(const Duration(milliseconds: 500));

    List<Map<String, dynamic>> jsonList = [
      {
        "id": "b_1001",
        "name": "深入理解计算机系统",
        "address": "北京市海淀区中关村大街1号",
        "createdAt": "2025-12-01T10:15:30.000Z",
        "pictureUrl": "https://example.com/images/book-1001.jpg",
      },
      {
        "id": "b_1002",
        "name": "代码整洁之道",
        "address": "上海市浦东新区张江高科园区88号",
        "createdAt": "2025-11-20T08:30:00.000Z",
        "pictureUrl": "https://example.com/images/book-1002.jpg",
      },
      {
        "id": "b_1003",
        "name": "领域驱动设计",
        "address": "深圳市南山区科技园南区16号",
        "createdAt": "2025-10-05T14:45:10.000Z",
        "pictureUrl": "https://example.com/images/book-1003.jpg",
      },
      {
        "id": "b_1004",
        "name": "重构：改善既有代码的设计",
        "address": "杭州市西湖区文三路90号",
        "createdAt": "2025-09-12T03:20:00.000Z",
        "pictureUrl": "https://example.com/images/book-1004.jpg",
      },
      {
        "id": "b_1005",
        "name": "设计模式：可复用面向对象软件的基础",
        "address": "成都市高新区天府三街99号",
        "createdAt": "2025-08-01T16:00:00.000Z",
        "pictureUrl": "https://example.com/images/book-1005.jpg",
      },
    ];

    // jsonList = [];

    return jsonList.map((json) => Book.fromJson(json)).toList();
  }
}
