import 'package:myapp/features/owner/services/equipment_service.dart';
import 'package:myapp/services/category_service.dart';

class AppStartup {
  Future<void> setupDummyData() async {
    await CategoryService().seedCategories();
    await EquipmentService().seedEquipment();
  }
}
