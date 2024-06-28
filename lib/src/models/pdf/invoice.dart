

import 'customer_info.dart';
import 'supplier.dart';

class Invoice {
  final InvoiceInfo? info;
  final Supplier? supplier;
  final Customer? customer;
  final List<InvoiceItem>? items;
  final List<InvoiceTotal>? total;
  final List<InvoiceGraph>? invoiceGraph;
  
    final List<InvoiceGraphHeader>? invoiceGraphHeader;

  const Invoice({
     this.info,
     this.supplier,
     this.customer,
     this.items,
     this.total,
     this.invoiceGraph,
     this.invoiceGraphHeader,
    //  this.shartnomaDate
  });
}

class InvoiceInfo {
  final String description;
  final String number;
  final String tableNumber;
  final DateTime date;
  final DateTime dueDate;

  const InvoiceInfo({
    required this.description,
    required this.number,
    required this.tableNumber,
    required this.date,
    required this.dueDate,
  });
}

class InvoiceItem {
  final String name;
  final int quantity;
  final String packaging;
  final String cost;

  const InvoiceItem({
    required this.name,
    required this.quantity,
    required this.packaging,
    required this.cost,
  });
}

class InvoiceTotal {
  final String cost;
  final String totalCost;

  const InvoiceTotal({
    required this.cost,
    required this.totalCost,
  });
}

class InvoiceGraph {
  final DateTime date;
  final double price;
  final int period;
  final double percent;
  final int number;
  

  const InvoiceGraph({
    required this.date,
    required this.price,
    required this.period,
    required this.percent,
    required this.number,
  });
}
class InvoiceGraphHeader {
  final DateTime date;
  final double price;
  final int period;
  final int percent;
  final int number;
  

  const InvoiceGraphHeader({
    required this.date,
    required this.price,
    required this.period,
    required this.percent,
    required this.number,
  });
}
