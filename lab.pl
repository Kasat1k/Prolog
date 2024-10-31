% Taxonomic (is_a) relationships
is_a(smartphone, electronics).
is_a(laptop, electronics).
is_a(tablet, electronics).
is_a(desktop_computer, electronics).
is_a(tv, electronics).
is_a(smart_tv, electronics).
is_a(smartwatch, electronics).
is_a(speaker, electronics).
is_a(printer, electronics).

% Basic electronics definition
is_a(electronics, device).

% Specific devices
is_a(samsung_galaxy, smartphone).
is_a(iphone, smartphone).
is_a(macbook, laptop).
is_a(dell_xps, laptop).
is_a(ipad, tablet).
is_a(galaxy_tab, tablet).
is_a(iMac, desktop_computer).
is_a(lenovo_desktop, desktop_computer).
is_a(samsung_smart_tv, smart_tv).
is_a(samsung_smart_tv, tv).

% Part-whole relationships
part_of(screen, smartphone).
part_of(battery, smartphone).
part_of(camera, smartphone).
part_of(processor, laptop).
part_of(keyboard, laptop).
part_of(trackpad, laptop).
part_of(screen, laptop).
part_of(battery, laptop).
part_of(screen, tablet).
part_of(battery, tablet).
part_of(camera, tablet).
part_of(motherboard, desktop_computer).
part_of(cpu, desktop_computer).
part_of(ram, desktop_computer).
part_of(storage, desktop_computer).
part_of(power_supply, desktop_computer).

% Additional relationship types
compatible_with(macbook, iphone).
compatible_with(galaxy_tab, samsung_galaxy).

% Транзитивність для перевірки електронних пристроїв
is_electronic_device(X) :- is_a(X, electronics).
is_electronic_device(X) :- is_a(X, Y), is_electronic_device(Y).

% Передача компонентів між сутностями в ієрархії 'is_a'
inherits_part_of(X, Y) :- part_of(X, Y).
inherits_part_of(X, Y) :- is_a(Z, Y), part_of(X, Z).
inherits_part_of(X, Z) :- part_of(X, Y), inherits_part_of(Y, Z).

% Заборона просування compatible_with через is_a
inherits_compatible_with(X, Y) :- compatible_with(X, Y).
inherits_compatible_with(X, Y) :- is_a(X, Z), inherits_compatible_with(Z, Y), \+ (is_a(Y, _)).

% Нескінченне виведення нових тверджень
exists_new_product(X) :- is_electronic_device(X).
exists_new_product(X) :- exists_new_product(Y), \+ (X = Y).

% Initialization for testing
:- initialization(main).

main :-
    % Test queries
    ( is_electronic_device(samsung_galaxy) ->
        write('Yes, Samsung Galaxy is an electronic device.');
        write('No, Samsung Galaxy is not an electronic device.')
    ),
    nl,
    ( inherits_part_of(screen, samsung_galaxy) ->
        write('Yes, Samsung Galaxy has a screen.');
        write('No, Samsung Galaxy does not have a screen.')
    ),
    nl,
    ( inherits_compatible_with(macbook, iphone) ->
        write('Yes, MacBook is compatible with iPhone.');
        write('No, MacBook is not compatible with iPhone.')
    ),
    nl,
    ( exists_new_product(future_device) ->
        write('Yes, there can exist a new product called Future Device.');
        write('No, Future Device cannot exist.')
    ),
    nl,
    ( is_a(smartphone, electronics) ->
        write('Yes, smartphone is an electronic device.');
        write('No, smartphone is not an electronic device.')
    ),
    nl,
    ( is_a(samsung_galaxy, smartphone) ->
        write('Yes, Samsung Galaxy is a smartphone device.');
        write('No, Samsung Galaxy is not a smartphone device.')
    ),
    nl,
    ( is_electronic_device(samsung_galaxy) ->
        write('Yes, Samsung Galaxy is an electronic device.');
        write('No, Samsung Galaxy is not an electronic device.')
    ),
    nl,
    ( is_electronic_device(samsung_smart_tv) ->
        write('Yes, Samsung Smart TV is an electronic device.');
        write('No, Samsung Smart TV is not an electronic device.')
    ),
    nl,
    ( compatible_with(macbook, iphone) ->
        write('Yes, MacBook is compatible with iPhone.');
        write('No, MacBook is not compatible with iPhone.')
    ),
    nl,
    halt.
