Dependencias
============
Three20 es la única dependencia por el momento y está incluido en el proyecto
como un submódulo (sub-repositorio). Para obtener mayor información de como
hacer pulling del codebase de Three20 referirse a README.md

Compilación del proyecto para el simulador (Debugging)
======================================================
Ejecutar lo siguiente desde la raiz del proyecto:

    xcodebuild -project src/PlazaVeaMovil/PlazaVeaMovil.xcodeproj \
        -configuration Debug -sdk iphonesimulator4.3

Con los procedimientos anteriores la configuración "Debug" se encarga de colocar
los símbolos de compilación necesarios para un proceso de depuración con el gdb.

Ejecución del simulador desde la terminal (Debugging)
=====================================================
Para esto será necesario clonar el repositorio ios-sim (fork de Fingertips):

    git clone https://github.com/Fingertips/ios-sim.git ios-sim-fingertips@git

Y luego compilarlo:

    cd ios-sim-fingertips@git
    xcodebuild -configuration Release

Finalmente copiar build/Release/ios-sim en alguna parte del $PATH (e.g. ~/bin).

Para ejecutar el app bundle ubicarse desde la raiz del proyecto y ejecutar:

    ios-sim launch \
        src/PlazaVeaMovil/build/Debug-iphonesimulator/PlazaVeaMovil.app \
        --verbose

El paso anterior asume que se compiló el proyecto con la configuración "Debug" y
para el simulador.

Depuración del código fuente utilizando el simulador (Debugging)
================================================================
Si el código objetivo se ejecuta inmediatamente después de cargar la app
entonces debe colocar un [NSThread sleepForTimeInterval:x], dónde x debe ser un
valor en segundos suficiente como para obtener la información del proceso del
simulador y abrir una sesión de gdb para que se anexe al simulador.

Luego de ejecutar el simulador abrir una terminal y ejecutar lo siguiente:

    ps axu | grep NombreDelAppBundle.app

Recuperar el process id y finalmente ejecutar lo siguiente:

    gdb NombreDelAppBundle.app ####

donde #### es el process id que recuperó en el paso anterior.

Una vez iniciada la sesión podrá colocar breakpoints, temporal breakpoints,
watchs, traps, etc. Ubique el archivo de código fuente (de extensión .m)
objetivo y la línea en la que desea causar la interrupción.

Luego ingrese lo siguiente:

    break NombreDelArchivo.m:##

donde ## es el núnmero de la línea.

El paso anterior es un ejemplo de breakpoint en el código. Para continuar
escriba: continue. Presione Enter. La aplicación continuará su flujo normal
hasta que alcance la línea con interrupción con lo que el simulador se
congelará y finalmente podrá depurar paso a paso el código.

Para obtener mayor información acerca del uso de gdb ir a una terminal y
ejecutar:

    man gdb

Configuración de un equipo de desarrollo (Debugging)
====================================================
Si no tiene certificado de desarrollo y no está incluido su certificado de
desarrollo en la configuación de provisión de desarrollo no podrá ejecutar este
paso ni el siguiente. Si desea estar incluido en el la provisión sea para
testing o para desarrollo enviar una solución a jchauvel@bitzeppelin.com.

Una guía de como obtener los assets necesarios para configurar un equipo como
desarrollo se encuentra en nuestro Basecamp, en Jedi Academy como [Assets para
desarrollo en iOS](https://bitzeppelin.basecamphq.com/W3835238).

Compilación del proyecto depuración desde el dispositivo (Debugging)
====================================================================
Prerequisitos: poseer un equipo configurado para desarrollo y poseer los
certificados necesarios para la provisión instalada. Referirse a "Configuración
de un equipo de desarrollo (Debugging)" y a [Assets para desarrollo en
iOS](https://bitzeppelin.basecamphq.com/W3835238), para obtener mayor
información de como proceder en ambos casos.

Luego de cerciorarse de poseer los requisitos se tiene que configurar el
proyecto para que la compilación de depuración se realice con la provisión y el
certificado personal. Abrir el proyecto ubicado en:
$(PROJECT\_ROOT)/src/PlazaVeaMovil/Projects/PlazaVeaMovil.xcodeproj 

Nota: solo se describirá como configurar el proyecto para la versión 4.0.2+ de
Xcode. Si desea hacerlo para versiones anteriores tendrá que migrar el proyecto.
Póngase en contacto con jchauvel@bitzeppelin.com para obtener mayor información.

Seleccione el target PlazaVeaMovil debajo de "Targets" (usualmente aparece en el
bloque del medio). Luego "Build Settings", ubicado en el bloque derecho relativo
a la ubicación del item que seleccionó anteriormente.

Utilizando la barra de búsqueda que apareció al seleccionar "Build Settings",
escriba: signing.

Expanda "Code Signing Identity" y seleccione su certificado (e.g. iPhone
Developer: Perico Los Palotes), el que está enparejado con "Testbed provisioning
profile for development (for Application Identifiers
'com.bitzeppelin.testbed')". Guardar el proyecto y salir de Xcode.

Ejecutar lo siguiente desde la raiz del proyecto:

    xcodebuild -project src/PlazaVeaMovil/PlazaVeaMovil.xcodeproj \
        -configuration Debug -sdk iphoneos4.3

Con los procedimientos anteriores la configuración "Debug" se encarga de colocar
los símbolos de compilación necesarios para un proceso de depuración remoto
con el gdb.

Distribución al dispositivo de desarrollo (Debugging)
=====================================================
Prerequisitos:

* Poseer un equipo configurado para desarrollo y poseer los
certificados necesarios para la provisión instalada. Referirse a "Configuración
de un equipo de desarrollo (Debugging)" y a [Assets para desarrollo en
iOS](https://bitzeppelin.basecamphq.com/W3835238), para obtener mayor
información de como proceder en ambos casos.

* Haber configurado el proyecto para compilar con certificados personales. Leer
la descripción del procedimiento en "Compilación del proyecto depuración desde
el dispositivo (Debugging)".

Abrir el proyecto de Xcode (ubicado en 
$(PROJECT\_ROOT)/src/PlazaVeaMovil/Projects/PlazaVeaMovil.xcodeproj).

Cerciorarse de que el "Scheme" esté seleccionado "iOS Device" o "iDevice" (en la
barra superior).

Paso seguido elegir la opción de menú Product -> Run, el proyecto será
compilado, si no lo estuviera aún, y será cargado en el equipo automáticamente
si fue configurado para desarrollo adecuadamente. Revisar el paso de
"Configuración de un equipo de desarrollo" si es que no se instala la app en el
dispositivo.
