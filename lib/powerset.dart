// Copyright (c) 2015, Harry Terkelsen. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

/// Returns the power set of the given [iterable]. This will also work with
/// infinite iterables. The power set of an iterable is an iterable that
/// contains all possible subsequences of that iterable.
Iterable<List<T>> powerset<T>(Iterable<T> iterable) sync* {
  var flags = <bool>[];
  var sequence = <T>[];
  var iterator = iterable.iterator;

  while (true) {
    var subset = <T>[];
    for (var i = 0; i < flags.length; i++) {
      if (flags[i]) subset.add(sequence[i]);
    }
    yield subset;

    var needsNext = true;
    for (var i = 0; i < flags.length; i++) {
      if (!flags[i]) {
        flags[i] = true;
        needsNext = false;
        break;
      } else {
        flags[i] = false;
      }
    }

    if (needsNext) {
      var hasNext = iterator.moveNext();
      if (!hasNext) {
        return;
      } else {
        sequence.add(iterator.current);
        flags.add(true);
      }
    }
  }
}
