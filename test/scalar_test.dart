// Import the test package and Counter class
import 'package:flutter_opencv/src/core/scalar.dart';
import 'package:flutter_test/flutter_test.dart';

import 'dart:async';

void main() {
  // Testing constructors__
  test('Create a Scalar using parameterized constructor', () {
    Scalar scalar = new Scalar(v0: 1);
    expect(scalar.val, [1, 0, 0, 0]);
  });

  test('Create a Scalar using parameterized constructor', () {
    Scalar scalar = new Scalar(v1: 1);
    expect(scalar.val, [0, 1, 0, 0]);
  });

  test('Create a Scalar using parameterized constructor', () {
    Scalar scalar = new Scalar(v2: 1);
    expect(scalar.val, [0, 0, 1, 0]);
  });

  test('Create a Scalar using parameterized constructor', () {
    Scalar scalar = new Scalar(v3: 1);
    expect(scalar.val, [0, 0, 0, 1]);
  });

  test('Create a Scalar using parameterized constructor', () {
    Scalar scalar = new Scalar(v0: 1, v1: 2, v2: 3, v3: 4);
    expect(scalar.val, [1, 2, 3, 4]);
  });

  test('Create a Scalar using named constructor ".fromArray()"', ()
  {
    Scalar scalar = new Scalar.fromArray([1, 2, 3, 4]);
    expect(scalar.val, [1, 2, 3, 4]);
  });

  // Testing Methods__
  // TODO There are troubles testing Platform Channels...
  // see open issue:
  test('Test "set()" method', ()
  async {
    Scalar scalar = new Scalar();
    await scalar.set([1, 2, 3, 4]);
    expect(scalar.val, [1, 2, 3, 4]);
  });
}