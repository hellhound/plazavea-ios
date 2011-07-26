Plaza Vea Móvil iOS app
=======================
Para clonar e inicializar los submodulos:

    git clone --recursive git@github.com:bitzeppelin/plazavea-ios.git \
        plazavea-ios@git

En dos comandos:

    git clone git@github.com:bitzeppelin/plazavea-ios.git plazavea-ios@git
    cd plazavea-ios@git
    git submodule init

Esta aplicacion hace uso de Three20 en la revision 41bdb73efb (post 1.0.6.2). 
Si se desea actualizar Three20 hay que parchar primero esta revision con los
parches del directorio patches y luego actualizar.
