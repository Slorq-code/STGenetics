import 'package:flutter/material.dart';
import '../Widgets/burger_card.dart';

class BurgerOptionsScreen extends StatefulWidget {
  BurgerOptionsScreen({Key? key}) : super(key: key);

  @override
  _BurgerOptionsScreenState createState() => _BurgerOptionsScreenState();
}

class _BurgerOptionsScreenState extends State<BurgerOptionsScreen> {
  final List<BurgerCard> burgerOptions = [
    const BurgerCard(name: 'X Burger', price: 5.00, category: 'sandwich'),
    const BurgerCard(name: 'X Egg', price: 4.50, category: 'sandwich'),
    const BurgerCard(name: 'X Bacon', price: 7.00, category: 'sandwich'),
  ];

  final List<BurgerCard> cartItems = [];

  final List<BurgerCard> extras = [
    const BurgerCard(name: 'Fries', price: 2.00, category: 'extras'),
    const BurgerCard(name: 'Soft Drink', price: 2.50, category: 'extras'),
  ];

  String customerName = '';

  double calculateSubtotal() {
    return cartItems.fold(0.0, (double total, item) => total + item.price);
  }

  double calculateDiscount() {
    if (containsCategory('sandwich') && containsCategory('extras')) {
      return calculateSubtotal() * 0.2; // 20% discount
    } else if (containsCategory('sandwich') && containsCategory('Soft Drink')) {
      return calculateSubtotal() * 0.15; // 15% discount
    } else if (containsCategory('sandwich') && containsCategory('Fries')) {
      return calculateSubtotal() * 0.1; // 10% discount
    } else {
      return 0.0; // No discount
    }
  }

  double calculateTotal() {
    double subtotal = calculateSubtotal();
    double discount = calculateDiscount();
    return subtotal - discount;
  }

  bool containsCategory(String category) {
    return cartItems.any((item) => item.category == category);
  }

  void addToCart(BurgerCard burger) {
    setState(() {
      if (burger.category == 'sandwich' && containsCategory('sandwich')) {
        // Error: Duplicate sandwich
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: const Text('Each order can only contain one sandwich.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
        return;
      }

      cartItems.add(burger);
    });
  }

  void removeCartItem(int index) {
    if (index >= 0 && index < cartItems.length) {
      setState(() {
        cartItems.removeAt(index);
      });
      Navigator.pop(context); //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Burger Options'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: burgerOptions.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    addToCart(burgerOptions[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: BurgerCard(
                      name: burgerOptions[index].name,
                      price: burgerOptions[index].price,
                      category: '',
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(),
          const ListTile(
            title: Text('Extras'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: extras.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    addToCart(extras[index]);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        title: Text(extras[index].name),
                        subtitle:
                            Text('\$${extras[index].price.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  children: [
                    const ListTile(
                      title: Text('Cart'),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartItems.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(cartItems[index].name),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                removeCartItem(index);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text('Subtotal'),
                      trailing:
                          Text('\$${calculateSubtotal().toStringAsFixed(2)}'),
                    ),
                    ListTile(
                      title: const Text('Discount'),
                      trailing:
                          Text('\$${calculateDiscount().toStringAsFixed(2)}'),
                    ),
                    ListTile(
                      title: const Text('Total'),
                      trailing:
                          Text('\$${calculateTotal().toStringAsFixed(2)}'),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Payment'),
                              content: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Customer Name',
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    customerName = value;
                                  });
                                },
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    // Perform payment and create order
                                    processPaymentAndCreateOrder();
                                  },
                                  child: const Text('Pay'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Text('Cancel'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: const Text('Confirm Payment'),
                    ),
                  ],
                ),
              );
            },
          );
        },
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  void processPaymentAndCreateOrder() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Order in Process'),
          content:
              Text('Thank you, $customerName! Your order is being processed.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );

    setState(() {
      cartItems.clear();
      customerName = '';
    });

    Navigator.pop(context); // Cerrar la modal del carrito de compras
  }
}
