import '../models/responce_model.dart';

abstract class ItResponceExceptionsFactory {
  ConexResponce<Data> handle<Data>(dynamic error);
}
