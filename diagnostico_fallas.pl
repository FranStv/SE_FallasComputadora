
%Hechos 
error(pantalla_azul).
error(pantalla_negra).
error(mensaje_error).
error(reinicio_abrupto).
error(reinicios_continuos).
error(no_puedo_ingresar).
error(critical_process_died).
error(system_thread_exception_not_handled).
error(irql_not_less_or_equal).
error(video_tdr_timeout_detected).
error(page_fault_in_nonpaged_area).
error(system_service_exception).
error(dpc_watchdog_violation).
error(ntfs_file_system).
error(data_bus_error).
error(kmode_exception_not_handled).
error(inaccessible_boot_device).

error(fecha_hora_reinicio).
error(cmos_error).
error(perdida_de_configuracion).

error(disco_no_detectado).
error(ram_no_detectada).
error(bajo_rendimiento).
error(inestabilidad_sistema).
error(no_arranca).
error(no_inicia_sistema).
error(no_hay_pitidos).
error(no_puedo_ingresar_ala_bios).
error(no_se_puede_cambiar_orden_arranque).
%Relaciones

proceso_critico_fallido(error(critical_process_died),error(pantalla_azul,mensaje_error)).
excepcion_no_controlada(error(system_thread_exception_not_handled),error(pantalla_azul),error(mensaje_error)).
memoria_no_paginada(error(irql_not_less_or_equal),error(pantalla_azul,mensaje_error)).
problema_video(error(video_tdr_timeout_detected),error(pantalla_azul),error(mensaje_error)).
problema_pagina_no_paginada(error(age_fault_in_nonpaged_area),error(pantalla_azul),error(mensaje_error)).
problema_servicio_excepcion(error(system_service_exception),error(pantalla_azul),error(mensaje_error)).
problema_dpc_watchdog(error(dpc_watchdog_violation),error(pantalla_azul,mensaje_error)).
problema_ntfs(error(ntfs_file_system),error(pantalla_azul),error(mensaje_error)).
problema_error_bus(error(data_bus_error),error(pantalla_azul),error(mensaje_error)).
problema_excepcion_no_controlada(error(kmode_exception_not_handled),error(pantalla_azul),error(mensaje_error)).
problema_dispositivo_inaccesible(error(inaccessible_boot_device),error(pantalla_azul),error(mensaje_error)).
reinicio_abrupto_sistema(error(reinicio_abrupto)).

bateria_cmos_agotada( error(fecha_hora_reinicio), error(cmos_error), error(perdida_de_configuracion)).
inestabilidad_general(error(bajo_rendimiento),error(inestabilidad_sistema)).
prende_pero_no_inicia_sistema(error(no_inicia_sistema)).
parece_muerta(error(no_hay_pitidos),error(no_arranca),error(pantalla_negra)).
bloqueo_bios(error(no_puedo_ingresar_ala_bios),error(no_se_puede_cambiar_orden_arranque)).
%Reglas logicas para problemas
%problema():- write('¿Tienes un código de error?'),nl,read(X), X = 'si', !, write('¿Qué código de error tienes?'),nl, read(Codigo), codigo_error(Codigo).
%problema(A,B,C,D) :- codigo_error(A), proceso_critico_fallido(A,B,C), reinicio_abrupto_sistema(D),write('Un proceso critico ha fallado').

%Problemas relacionados con pantalla azul
problema(error(pantalla_azul), error(mensaje_error), error(reinicio_abrupto), error(critical_process_died)) :- 
    proceso_critico_fallido(error(critical_process_died),error(pantalla_azul),error(mensaje_error)),
    reinicio_abrupto_sistema(error(reinicio_abrupto)),
    write('Problema detectado: Indica que un proceso crítico del sistema ha dejado de funcionar, posiblemente debido a una finalización accidental en el Administrador de tareas.'), nl.
problema(error(pantalla_azul), error(mensaje_error), error(reinicio_abrupto), error(system_thread_exception_not_handled)) :- 
    excepcion_no_controlada(error(system_thread_exception_not_handled),error(pantalla_azul),error(mensaje_error)),
    reinicio_abrupto_sistema(error(reinicio_abrupto)),
    write('Problema detectado: Suele estar relacionado con un controlador obsoleto, dañado o incompatible. '), nl.
problema (error(pantalla_azul), error(mensaje_error), error(reinicio_abrupto), error(irql_not_less_or_equal)) :- 
    memoria_no_paginada(error(irql_not_less_or_equal),error(pantalla_azul),error(mensaje_error)),
    reinicio_abrupto_sistema(error(reinicio_abrupto)),
    write('Problema detectado: Indica que el software de un dispositivo o un proceso del sistema ha intentado acceder a más memoria de la permitida. '), nl.
problema(error(pantalla_azul), error(mensaje_error), error(reinicio_abrupto), error(video_tdr_timeout_detected)) :-
    problema_video(error(video_tdr_timeout_detected),error(pantalla_azul),error(mensaje_error)),
    reinicio_abrupto_sistema(error(reinicio_abrupto)),
    write('Problema detectado: Indica que el controlador de pantalla no ha respondido a tiempo y ha sido reiniciado.'), nl.
problema(error(pantalla_azul), error(mensaje_error),error( reinicio_abrupto), error(page_fault_in_nonpaged_area)) :-
    problema_pagina_no_paginada(error(page_fault_in_nonpaged_area),error(pantalla_azul),error(mensaje_error)),
    reinicio_abrupto_sistema(error(reinicio_abrupto)),
    write('Problema detectado: Indica que el sistema ha intentado acceder a una parte de la memoria que no está disponible.'), nl.
 problema(error(pantalla_azul), error(mensaje_error), error(reinicio_abrupto), error(system_service_exception)) :-
    problema_servicio_excepcion(error(system_service_exception),error(pantalla_azul),error(mensaje_error)),
    reinicio_abrupto_sistema(error(reinicio_abrupto)),
    write('Problema detectado: Indica que un servicio del sistema ha fallado.'), nl.
problema(error(pantalla_azul), error(mensaje_error), error(reinicio_abrupto), error(dpc_watchdog_violation)) :-
    problema_dpc_watchdog(error(dpc_watchdog_violation),error(pantalla_azul),error(mensaje_error)),
    reinicio_abrupto_sistema(error(reinicio_abrupto)),
    write('Problema detectado: Indica que el sistema ha tardado demasiado en procesar una solicitud de hardware.'), nl.
problema(error(pantalla_azul), error(mensaje_error), error(reinicio_abrupto), error(ntfs_file_system)) :-
    problema_ntfs(error(ntfs_file_system),error(pantalla_azul),error(mensaje_error)),
    reinicio_abrupto_sistema(error(reinicio_abrupto)),
    write('Problema detectado: Indica un problema con el sistema de archivos NTFS.'), nl.
problema(error(pantalla_azul),error( mensaje_error), error(reinicio_abrupto),error( data_bus_error)) :-
    problema_error_bus(error(data_bus_error),error(pantalla_azul),error(mensaje_error)),
    reinicio_abrupto_sistema(error(reinicio_abrupto)),
    write('Problema detectado: Indica un error en la comunicación entre la memoria y el procesador.'), nl.
problema(error(pantalla_azul), error(mensaje_error), error(reinicio_abrupto), error(kmode_exception_not_handled)) :-
    problema_excepcion_no_controlada(error(kmode_exception_not_handled),error(pantalla_azul),error(mensaje_error)),
    reinicio_abrupto_sistema(error(reinicio_abrupto)),
    write('Problema detectado: Indica que el sistema ha encontrado un error en el modo kernel.'), nl.
problema(error(pantalla_azul), error(mensaje_error), error(reinicio_abrupto), error(inaccessible_boot_device)) :-
    problema_dispositivo_inaccesible(error(inaccessible_boot_device),error(pantalla_azul),error(mensaje_error)),
    reinicio_abrupto_sistema(error(reinicio_abrupto)),
    write('Problema detectado: Indica que el sistema no puede acceder al dispositivo de arranque.'), nl.  

%Problemas relacionados con BIOS
problema(error(fecha_hora_reinicio), error(cmos_error), error(perdida_de_configuracion)) :-
    bateria_cmos_agotada(error(fecha_hora_reinicio), error(cmos_error), error(perdida_de_configuracion)),
    write('Problema detectado: La batería CMOS está agotada, lo que puede causar pérdida de configuración y problemas de fecha y hora.'), nl.

problema(error(disco_no_detectado), error(ram_no_detectada), error(bajo_rendimiento),error(inestabilidad_sistema),error(no_arranca)) :-
    inestabilidad_general(error(bajo_rendimiento),error(inestabilidad_sistema));error(no_arranca);error(disco_no_detectado);error(ram_no_detectada),
    write('Problema detectado: Configuración incorrecta de la bios.'), nl.

problema(error(no_inicia_sistema),error(no_hay_pitidos),error(pantalla_negra)) :-
    prende_pero_no_inicia_sistema(error(no_inicia_sistema)),
    error(no_hay_pitidos),
    error(pantalla_negra),
    write('Problema detectado:Revisa el funcionamiento y compatibilidad de los componentes, en especial la RAM , el procesador y la tarjeta madre, la tarjeta gráfica.
    Si funcionan entoces posiblemente la bios este corrupta o dañada.'), nl.
    

problema(error(no_puedo_ingresar_ala_bios), error(no_se_puede_cambiar_orden_arranque)) :-
    bloqueo_bios(error(no_puedo_ingresar_ala_bios),error(no_se_puede_cambiar_orden_arranque)),
    write('Problema detectado: Parece ser que la bios se bloqueo con contraseña.'), nl.