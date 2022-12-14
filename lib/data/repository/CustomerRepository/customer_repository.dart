import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:library_flutter/domain/models/Customer/customer.dart';

class CustomerRepository {
  final String _baseUrl = "http://localhost:5000/api/v3";

  Future<List<Customer>> getAll() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/Usuario'));

      if (response.statusCode != 200) {
        throw Exception();
      } else {
        final decodedBody = jsonDecode(response.body);
        final body = (decodedBody as List);
        final data = body.map((item) => Customer.fromJson(item)).toList();

        return data;
      }
    } catch (err) {
      return List.empty();
    }
  }

  Future<http.Response> post(Customer customer) async {
    return await http.post(
      Uri.parse('$_baseUrl/Usuario'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: jsonEncode(
        {
          'nome': customer.name,
          'email': customer.email,
          'cidade': customer.city,
          'endereco': customer.address,
        },
      ),
      encoding: Encoding.getByName("utf-8"),
    );
  }

  Future<http.Response> put(Customer customer) async {
    return await http.put(
      Uri.parse('$_baseUrl/Usuario/${customer.id}'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/json"
      },
      body: jsonEncode(
        {
          'id': customer.id,
          'nome': customer.name,
          'email': customer.email,
          'cidade': customer.city,
          'endereco': customer.address,
        },
      ),
      encoding: Encoding.getByName("utf-8"),
    );
  }

  Future<http.Response> delete(Customer customer) async {
    return await http.delete(Uri.parse('$_baseUrl/Usuario/${customer.id}'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },
        encoding: Encoding.getByName("utf-8"));
  }
}
