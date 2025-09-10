import 'package:tononkira_pcl/dao/category_dao.dart';
import 'package:tononkira_pcl/entity/category.dart';

class CategoryService {
  static Future<List<Category>> loadCategories() {
    return CategoryDAO.loadCategories();
  }
}
