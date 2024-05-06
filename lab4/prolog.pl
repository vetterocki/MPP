:- initialization(example).

% Факт: алфавіт
alphabet(['A', 'B', 'C', 'D']).

% Правило: сортування масиву
sorted_array(Array, SortedArray) :-
    sort(Array, SortedArray).

% Правило: створення відображення інтервалів
create_interval_map(SortedArray, AlphabetPower, IntervalMap) :-
    length(SortedArray, ArrayLength),
    IntervalSize is ArrayLength // AlphabetPower,
    create_map(SortedArray, IntervalSize, 0, AlphabetPower, IntervalMap).

create_map([], _, _, _, []).
create_map([Number|Numbers], IntervalSize, J, AlphabetPower, [Number-Char|Rest]) :-
    J1 is J + 1,
    CharIndex is (J1 - 1) // IntervalSize,
    alphabet(Alphabet),
    nth0(CharIndex, Alphabet, Char),
    create_map(Numbers, IntervalSize, J1, AlphabetPower, Rest).

% Правило: відображення чисел на символи
map_values_to_chars([], _, []).
map_values_to_chars([Number|Numbers], IntervalMap, [Char|Chars]) :-
    member(Number-Char, IntervalMap),
    map_values_to_chars(Numbers, IntervalMap, Chars).

% Правило: створення матриці присутності символів
create_presence_matrix(Array, IntervalMap, Alphabet, Matrix) :-
    create_presence_rows(Array, IntervalMap, Alphabet, MatrixRows),
    prepend_header(Alphabet, MatrixRows, Matrix).

create_presence_rows([], _, _, []).
create_presence_rows([Number|Numbers], IntervalMap, Alphabet, [Row|Rows]) :-
    map_values_to_chars([Number], IntervalMap, [Char]),  % Map single number to its corresponding char
    create_row(Char, Alphabet, Row),
    create_presence_rows(Numbers, IntervalMap, Alphabet, Rows).

create_row(Char, Alphabet, Row) :-
    length(Alphabet, Length),
    create_row(Char, Length, 0, Row).

create_row(_, Length, Length, []).
create_row(Char, Length, Index, [Value|Rest]) :-
    (Index = Char -> Value = 1 ; Value = 0),
    NextIndex is Index + 1,
    create_row(Char, Length, NextIndex, Rest).

prepend_header(Alphabet, MatrixRows, [Header|MatrixRows]) :-
    prepend_header_row(Alphabet, Header).

prepend_header_row([], []).
prepend_header_row([Char|Chars], [Char|HeaderRest]) :-
    prepend_header_row(Chars, HeaderRest).

% Приклад використання:
example :-
    Array = [9, 1, 6, 7, 3, 4, 5, 10],
    sorted_array(Array, SortedArray),
    write('Sorted Array: '), write(SortedArray), nl,
    AlphabetPower = 4,
    create_interval_map(SortedArray, AlphabetPower, IntervalMap),
    write('Interval Map: '), write(IntervalMap), nl,
    map_values_to_chars(Array, IntervalMap, Chars),
    write('Mapped Chars: '), write(Chars), nl,
    alphabet(Alphabet),
    create_presence_matrix(Array, IntervalMap, Alphabet, Matrix),
    display_matrix(Alphabet, Matrix).

display_matrix(Alphabet, Matrix) :-
    write('  '), write_list(Alphabet), nl,
    display_matrix_rows(Alphabet, Matrix).

write_list([]).
write_list([X|Xs]) :-
    write(X), write(' '),
    write_list(Xs).

display_matrix_rows([], []).
display_matrix_rows([Char|Chars], [Row|Rows]) :-
    write(Char), write(' '),
    write_list(Row), nl,
    display_matrix_rows(Chars, Rows).
