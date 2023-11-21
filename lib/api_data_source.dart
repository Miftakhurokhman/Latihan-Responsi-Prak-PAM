import 'base_network.dart';

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  Future<Map<String, dynamic>> loadNews() {
    return BaseNetwork.get("articles/?format=json");
  }

  Future<Map<String, dynamic>> loadBlog() {
    return BaseNetwork.get("blogs/?format=json");
  }

  Future<Map<String, dynamic>> loadReport() {
    return BaseNetwork.get("reports/?format=json");
  }

  Future<Map<String, dynamic>> loadDetailNews(int idDiterima){
    String id = idDiterima.toString();
    return BaseNetwork.get("articles/?format=json/$id");
  }

  Future<Map<String, dynamic>> loadDetailBlog(int idDiterima){
    String id = idDiterima.toString();
    return BaseNetwork.get("blogs/?format=json/$id");
  }

  Future<Map<String, dynamic>> loadDetailReport(int idDiterima){
    String id = idDiterima.toString();
    return BaseNetwork.get("reports/?format=json/$id");
  }
}
