part of atoms;

//
// Atom Typedefs
//

typedef AtomComparator = bool Function(Reader read);
typedef AtomComparatorWith<T> = bool Function(Reader read, T value);
typedef ValueCallback<T> = void Function(T value);
typedef PairCallback<T, K> = void Function(T previous, K current);
