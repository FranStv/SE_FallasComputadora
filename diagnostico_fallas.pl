%Hechos dinamicos para guardar las posibles respuestas del usuario
% (si,no) mientras el programa corre
% /1 significa que resiben un argumento

:- dynamic si/1, no/1.

%Reglas logicas para problemas de hardware

problema_hardware('Disco duro dañado o con sectores defectuosos') :-
    verificar(archivos_corruptos),
    verificar(lentitud_extrema);
    verificar(errores_arranque);
    verificar(ruidos_extranos).

%Reglas logicas para problemas de software

problema_software('Sistema operativo dañado o corrupto') :-
    verificar(no_arranca);
    verificar(errores_inicio);
    verificar(reinicios_bucle).

%Causas Hardware
causa_hardware('Disco duro dañado o con sectores defectuosos', 'Desgaste, golpes físicos, cortes de energía').

%Causas software
causa_software('Sistema operativo dañado o corrupto', 'Apagados incorrectos, virus, actualizaciones fallidas').

% Recomendaciones hardware
recomendacion_hardware('Disco duro dañado o con sectores defectuosos', 'Respaldar datos y reemplazar el disco duro').


% Recomendaciones software
recomendacion_software('Sistema operativo dañado o corrupto', 'Reparar con disco de instalación o reinstalar SO').


verificar(Sintoma) :-
    si(Sintoma), !.

verificar(Sintoma) :-
    no(Sintoma), !, fail.

verificar(Sintoma) :-
    preguntar(Sintoma).

preguntar(Sintoma) :-
    traducir(Sintoma, Texto),
    write(Texto), write(' (s/n): '),
    read(Resp),
    ( (Resp == s, assertz(si(Sintoma)));
      (assertz(no(Sintoma)), fail) ).

%Traducción de los sintomas
traducir(archivos_corruptos, '¿Los archivos aparecen corruptos?').
traducir(lentitud_extrema, '¿El sistema está extremadamente lento?').
traducir(errores_arranque, '¿Hay errores al arrancar?').
traducir(ruidos_extranos, '¿Escuchas ruidos extraños del disco duro?').
traducir(no_arranca, '¿El equipo no arranca?').
traducir(errores_inicio, '¿Errores al iniciar el sistema?').
traducir(reinicios_bucle, '¿Reinicios en bucle?').



% Limpia respuestas para una nueva sesión
limpiar :-
    retract(si(_)), fail.
limpiar :-
    retract(no(_)), fail.
limpiar.


iniciar :-
    write('¿El problema es de hardware o software? (hardware/software): '), read(Resp),
    diagnosticar(Resp),
    limpiar.

iniciar :-
    write("No se pudo determinar un diagn�stico con la informaci�n proporcionada."), nl.

% Diagnóstico general según tipo
diagnosticar(hardware) :-
    problema_hardware(Problema),
    write('\nDiagnóstico: '), write(Problema), nl,
    causa_hardware(Problema, Causa),
    write('Causa común: '), write(Causa), nl,
    recomendacion_hardware(Problema, Reco),
    write('Recomendación: '), write(Reco), nl.

diagnosticar(software) :-
    problema_software(Problema),
    write('\nDiagnóstico: '), write(Problema), nl,
    causa_software(Problema, Causa),
    write('Causa común: '), write(Causa), nl,
    recomendacion_software(Problema, Reco),
    write('Recomendación: '), write(Reco), nl.