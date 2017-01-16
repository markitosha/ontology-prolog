/*
    Маркитантова Наталья
    424 группа
    Онтология животных
*/

:- dynamic rule/4.
:- dynamic cond/2.

% правила -- база знаний
% имеет вид: rule(номер_правила, имя_родителя_объекта, имя_объекта, список_номеров_свойств_объекта)
rule(1, "животное", "млекопитающее", [11, 12]).
rule(2, "животное", "птица", [8, 13]).
rule(3, "животное", "пресмыкающиеся", [19]).
rule(4, "животное", "насекомое", [20, 21]).
rule(5, "млекопитающее", "хищник", [14, 15, 16]).
rule(6, "млекопитающее", "парнокопытное", [17, 18]).
rule(7, "птица", "страус", [5, 7]).
rule(8, "птица", "пингвин", [9, 7]).
rule(9, "птица", "попугай", [6, 22, 23, 24]).
rule(10, "птица", "курица", [24, 25]).
rule(11, "птица", "гусь", [4, 24]).
rule(12, "пресмыкающиеся", "ящерица", [31, 32]).
rule(13, "пресмыкающиеся", "крокодил", [9, 16]).
rule(14, "пресмыкающиеся", "черепаха", [29, 30]).
rule(15, "пресмыкающиеся", "уж", [26, 27]).
rule(16, "пресмыкающиеся", "гадюка", [26, 28]).
rule(17, "хищник", "гепард", [1, 2, 33]).
rule(18, "хищник", "тигр", [1, 3, 33]).
rule(19, "хищник", "кошка", [24, 34]).
rule(20, "хищник", "собака", [24, 35]).
rule(21, "хищник", "волк", [33, 36]).
rule(22, "парнокопытное", "жираф", [5, 4, 2, 33]).
rule(23, "парнокопытное", "зебра", [3, 33]).
rule(24, "парнокопытное", "корова", [2, 7, 24]).
rule(25, "парнокопытное", "лошадь", [24]).
rule(26, "парнокопытное", "олень", [33, 36]).
rule(27, "насекомое", "комар", [6, 36, 37, 38]).
rule(28, "насекомое", "таракан", [29, 40]).
rule(29, "насекомое", "богомол", [25, 39]).
rule(30, "насекомое", "стрекоза", [6, 23]).
rule(31, "насекомое", "муха", [6, 41]).

% свойства объекта
% имеет вид: cond(номер_свойства, значение_свойства)
cond(1, "имеет рыжий цвет").
cond(2, "имеет темные пятна").
cond(3, "имеет черные полосы").
cond(4, "имеет длинную шею").
cond(5, "имеет длинные ноги").
cond(6, "летает").
cond(7, "имеет черный и белый цвет").
cond(8, "имеет перья").
cond(9, "плавает").
cond(10, "летает хорошо").
cond(11, "имеет шерсть").
cond(12, "кормит детенышей молоком").
cond(13, "откладывает яйца").
cond(14, "ест мясо").
cond(15, "имеет когти").
cond(16, "имеет острые зубы").
cond(17, "жует жвачку").
cond(18, "имеет копыта").
cond(19, "хладнокровное").
cond(20, "имеет фасеточные глаза").
cond(21, "имеет шесть ног").
cond(22, "разговаривает").
cond(23, "имеет яркий окрас").
cond(24, "одомашнено").
cond(25, "плохо летает").
cond(26, "не имеет ног").
cond(27, "имеет яд").
cond(28, "не имеет яд").
cond(29, "имеет панцирь").
cond(30, "медленно двигается").
cond(31, "отбрасывает хвост").
cond(32, "имеет цветное зрение").
cond(33, "дикое").
cond(34, "ест мышей").
cond(35, "ест кошек").
cond(36, "живет в лесу").
cond(37, "имеет небольшой размер").
cond(38, "пьет кровь").
cond(39, "ест самца после спаривания").
cond(40, "не боится радиации").
cond(41, "хорошо уворачивается").

% *--ВЫВОД АТРИБУТОВ--*

% Основная функция вывода атрибутов
go(_, Mygoal) :- not(rule(_, _, Mygoal, _)), write("*--Конец атрибутов--*").
go(HISTORY, Mygoal) :- rule(RNO, NY, Mygoal, COND), check(RNO, HISTORY, COND), go([RNO | HISTORY], NY).

% Функция для вывода свойств одного уровня
check(RNO, HISTORY, [BNO | REST]) :- cond(BNO, TEXT_COND), write(TEXT_COND), nl, check(RNO, HISTORY, REST).
check(_, _, []).

% *--СВОЙСТВО ОБЪЕКТА--*

% Основная функция определения свойства объекта
go1(_, Mygoal, _) :- not(rule(_, _, Mygoal, _)), !, fail.
go1(HISTORY, Mygoal, Attr) :- rule(RNO, _, Mygoal, COND), check1(RNO, HISTORY, COND, Attr), !.
go1(HISTORY, Mygoal, Attr) :- rule(RNO, NY, Mygoal, _), go1([RNO | HISTORY], NY, Attr).

% Функция для поиска свойства на одном уровне
check1(_, _, [BNO | _], Attr) :- cond(BNO, Attr), !.
check1(RNO, HISTORY, [_ | REST], Attr) :- check1(RNO, HISTORY, REST, Attr).
check1(_, _, [], _) :- !, fail.

% *--РАЗЛИЧИЯ ОБЪЕКТОВ--*

% Основная функция поиска различий между объектами
go2(_, X, X) :- write("Объекты одинаковы"), !.
go2(_, Mygoal, Mygoal2) :- write("*--Совпадения--*"), nl, go3(_, Mygoal), go4(_, Mygoal2), write_diff(Mygoal, Mygoal2).

% Проход по всем свойствам первого объекта
go3(_, Mygoal) :- not(rule(_, _, Mygoal, _)).
go3(HISTORY, Mygoal) :- rule(RNO, NY, Mygoal, COND), check3(RNO, HISTORY, COND), go3([RNO | HISTORY], NY).

% Запись всех свойств объекта в динамическую память
check3(RNO, HISTORY, [BNO | REST]) :- diff1(BNO), !, check3(RNO, HISTORY, REST).
check3(RNO, HISTORY, [BNO | REST]) :- cond(BNO, _), assert(diff1(BNO)), check3(RNO, HISTORY, REST).
check3(_, _, []).

% Проход по всем свойствам второго объекта
go4(_, Mygoal) :- not(rule(_, _, Mygoal, _)).
go4(HISTORY, Mygoal) :- rule(RNO, NY, Mygoal, COND), check4(RNO, HISTORY, COND), go4([RNO | HISTORY], NY).

/*
% Удаление повторяющихся свойств из динамической памяти, занесение туда оригинальных свойств второго объекта
check4(RNO, HISTORY, [BNO | REST]) :- diff1(BNO), retract(diff1(BNO)), !, check4(RNO, HISTORY, REST).
check4(RNO, HISTORY, [BNO | REST]) :- diff2(BNO), !, check4(RNO, HISTORY, REST).
check4(RNO, HISTORY, [BNO | REST]) :- cond(BNO, _), assert(diff2(BNO)), check4(RNO, HISTORY, REST).
check4(_, _, []).
*/

% Пересечение повторяющихся свойств
check4(RNO, HISTORY, [BNO | REST]) :- diff1(BNO), assert(diff2(BNO)), !, check4(RNO, HISTORY, REST).
check4(RNO, HISTORY, [BNO | REST]) :- diff2(BNO), !, check4(RNO, HISTORY, REST).
check4(RNO, HISTORY, [BNO | REST]) :- cond(BNO, _), check4(RNO, HISTORY, REST).
check4(_, _, []).

/*
% Вывод различающихся свойств и очищение динамической памяти
write_diff(X, Y) :- diff1(BNO), cond(BNO, TEXT_COND), write(X), write(": "), write(TEXT_COND), nl, retract(diff1(BNO)), write_diff(X, Y).
write_diff(X, Y) :- diff2(BNO), cond(BNO, TEXT_COND), write(Y), write(": "), write(TEXT_COND), nl, retract(diff2(BNO)), write_diff(X, Y).
write_diff(_, _).
*/

% Вывод совпадающих свойств и очищение динамической памяти
write_diff(X, Y) :- diff2(BNO), cond(BNO, TEXT_COND), write(TEXT_COND), nl, retract(diff2(BNO)), write_diff(X, Y).
write_diff(_, _).

% *--ДОБАВЛЕНИЕ ОБЪЕКТОВ--*

% Исновная функция добавление объектов
go5(_, X, X) :- write("Объекты одинаковы"), !.
go5(_, Parent, Mygoal) :- length_rule(N), choose('y', L), assert(rule(N, Parent, Mygoal, L)).

% Определение первого свободного номера среди правил
length_rule(N1) :- findall(N, rule(N, _, _, _), List), length(List, N), N1 is N + 1.

% Определение первого свободного номера среди свойств
length_cond(N1) :- findall(N, cond(N, _), List), length(List, N), N1 is N + 1.

% Добавление новых свойств
choose(Y, [BNO | List]) :- Y='y', write("Введите свойство: "), nl, read(X), find_add(X, BNO), write("Продолжить? y - да, n - нет"), nl, read(M), choose(M, List).
choose(_, []).

% Поиск и добавление новых свойств в динамическую базу данных и в новый список свойств
find_add(X, BNO) :- cond(BNO, X), !.
find_add(X, BNO) :- length_cond(BNO), assert(cond(BNO, X)), !.


% Очищение динамической базы данных
delete_all:-retract(diff1(_)),delete_all.
delete_all:-retract(diff2(_)),delete_all.
delete_all.

% Пользовательский интерфейс
run :- delete_all, write("Что вы хотите сделать? 1 - вывести все свойства объекта, 2 - узнать наличие свойства у объекта, 3 - найти различия между объектами, 4 - добавить новый объект\n"), read(N), run(N).
run(1) :- write("Введите название объекта, чтобы посмотреть его свойства:\n"), read(Y), go(_, Y).
run(2) :- write("Введите название объекта:\n"), read(X), write("Введите свойство:\n"), read(Y), go1(_, X, Y).
run(3) :- write("Введите название первого объекта:\n"), read(X), write("Введите название второго объекта:\n"), read(Y), go2(_, X, Y).
run(4) :- write("Введите название нового объекта:\n"), read(Y), write("Введите название родителя нового объекта:\n"), read(X), go5(_, X, Y).
