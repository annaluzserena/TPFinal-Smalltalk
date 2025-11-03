# TPFinal-Smalltalk
|col |


nom:=Prompter prompt: 'Ingrese nombre de la biblioteca'.
barrio:=Prompter prompt:'Ingrese barrio de la biblioteca'.
anio:=(Prompter  prompt: 'Ingrese anio de creacion')asNumber .
cantper:=(Prompter prompt: 'Ingrese cantidad de personal de la biblioteca')asNumber.

biblio:= Biblioteca crearBiblioNom: nom anio:anio barrio:barrio personal: cantper.
"Menu para TP integrador"

| seguir op dicOp lib biblio libro col col1 col2 col3 col4|

dicOp:= OrderedDictionary new.
dicOp 
        at: 1 put: '1 - Cargar libros';
	at: 2 put: '2 - Buscar libro (Modificar/Eliminar)';
	at: 3 put: '3 - Listar libros con mas de 5 copias';
	at: 4 put: '4 - Listar libros ochentosos';
	at: 5 put: '5 - Listar cantidad de libros por genero';
	at: 6 put: '6 - Eliminar libros sin stock';
	at: 0 put: '0 - Salir';
	yourself.

seguir:= true.

[seguir] whileTrue: [
	"Menu implementado con un diccionario que devuelve un numero (dependiendo la opcion) en vez de un string"
	op:= dicOp keyAtValue: (ChoicePrompter choices: (dicOp values asOrderedCollection) caption: 'Menu - Gestion de libros').
        
        (op==1 ) IfTrue [
      [seg] whileTrue: [
       choice := MessageBox choices: {'Regular'. 'Manual'} .
       choice=='Regular' ifTrue [ libro:=LibroRegular crear: nom con: aniopub con: genero con: codigo con:stock.
         nom:=  Prompter prompt:'Ingrese titulo del libro' .
         aniopub:= (Prompter prompt: 'Ingrese anio d epublicacion').
         genero:=Prompter  prompt:  'Ingrese genero del libro'.
         codigo:=(Prompter  prompt:  'Ingrese codigo de identificacion')asNumber.
         stock:=(Prompter  prompt: 'Ingrese cantidad de copias disponibles' )asNumber. 
].
       choice=='Manual' ifTrue [libro:=LibroManual crear: nom con: aniopub con:genero con: codigo con:stock con:cant.
         nom:=  Prompter prompt:'Ingrese titulo del libro' .
         aniopub:= (Prompter prompt: 'Ingrese anio d epublicacion').
         genero:=Prompter  prompt:  'Ingrese genero del libro'.
         codigo:=(Prompter  prompt:  'Ingrese codigo de identificacion')asNumber.
         stock:=(Prompter  prompt: 'Ingrese cantidad de copias disponibles' )asNumber.
         cant:=(Prompter  prompt: 'Ingrese cantidad de veces que se presto' )asNumber.
         ].
       biblio agregarLibro: libro.
       seg:=MessageBox confirm: 'Desea seguir cargando otro libro'.
         ].
     ].
      (op==2)  ifTrue: [ 
     [seguir] whileTrue: [ codigo:= (Prompter prompt: 'Ingrese codigo del libro ')asNumber.
        col:= biblio verTodos. 
        libro := col detect: [: libro| libro vercodigo == cod ].
        listar:= [ : libro | Transcript  show : 'Titulo:', (libro  vertitulo); cr ;
                                   show: 'Genero:', (libro vergenero) ; cr;
                                   show: 'Tipo:', (libro vertipo);cr;
                                   show: 'Anio de creacion:' , (libro veraniopub); cr;
                                   show: 'Stock:', (libro vercantcopias).

      choice := MessageBox choices: {'Modificar'. 'Eliminar'. 'Salir'} .
      choice== 'Modificar' ifTrue: [ [s] whileTrue: [ choice := MessageBox choices: {'Titulo'. 'Genero'. 'Codigo' . 'Stock'. 'Anio'.'Salir'} .
          choice== 'Titulo' ifTrue [ nomnuevo:= Prompter prompt: 'Ingrese el nuevo nombre del libro'.
          libro modTitulo: nomnuevo].
          choice== 'Genero' ifTrue [generonuevo:= Prompter prompt: 'Ingrese el nuevo genero del libro'.  libro modgenerp: generonuevo.
          Transcrip show: 'Se ha cambiado el titulo con exito'].
          choice== 'Codigo' ifTrue[codigonuevo:= (Prompter prompt: 'Ingrese el nuevo nombre del libro')asNumber. 
           colcodigos:= col collect: [:libro | libro verCodigo]].
           ((colcodigos occurrencesOf: codigonuevo)>0 ) ifTrue: [MessageBox  notify: 'ERROR!! Ya existe un libro con ese codigo'. ]
           ifFalse: [ libro modcodigo: codigonuevo. Transcript show: 'Se ha cambiado el codigo con exito'. ].

          choice=='Stock' ifTrue [stocknuevo:= (Prompter prompt: 'Ingrese nuevo stock del libro')asNumber.
          libro modStock: stocknuevo. Transcript show: 'Se ha cambiado el stock con exito'].
          choice== 'Anio' ifTrue [anionuevo:= Prompter prompt: 'Ingrese el anio del libro'.
          libro modanio: anionuevo. Transcript show: 'Se a cambiado el anio con exito'].
          choice=='Salir' ifTrue [s==False ].
                ].
      choice== 'Eliminar' ifTrue[ biblio eliminarLibro: libro.
     Transcript show:'Libro elimindado con exito'. ].
].
].
   seguir:=MessageBox confirm: 'Desea buscar otro libro'.
         ].
             ].
        ].
    ].
     (op==3) ifTrue: [ 
        col1:= biblio verTodos.
        cant5:= col1 select: [: libro| 
                                        libro verStock >= 5].
        cant5 do: [:libro |  
                                   Transcript  show: libro 'Titulo:', (libro  vertitulo); cr ;
                                   show: 'Genero:', (libro vergenero) ; cr;
                                   show: 'Tipo:', (libro vertipo);cr;
                                   show: 'Anio de creacion:' , (libro veraniopub); cr. ].
        ].
       (op==4)ifTrue: [
        col2:=biblio verTodos.
        ochentoso:= col2 select: [:libro| libro veraniopub 1980 and: [libro veraniopub <=  1990] ].
        ochetonso do: [:libro | 
                                   Transcript  show: : 'Titulo:', (libro  vertitulo); cr ;
                                   show: 'Genero:', (libro vergenero) ; cr;
                                   show: 'Tipo:', (libro vertipo);cr;
                                   show: 'Anio de creacion:' , (libro veraniopub); cr;
                                   show: 'Stock:', (libro vercantcopias).
       ].
       (op==5)ifTrue: [
       gen:=Prompter prompt: 'Ingrese el genero del libro:'.
       col3:=biblio verTodos.
       cantgenero:= col3 select: [:libro|
                                                  libro ver genero == gen].
       cantgenero do: [:libro|  
                                  Transcript show:   'Stock:', (libro vercantcopias).]
      ].
       (op=6)ifTrue: [ 
       col4:=biblio verTodos.
       sincantidad:=col4 select: [: libro | 
                                    libro verstock == 0].
       sincantidad do: [: libro| biblio eliminarLibro: libro ].
          
].
].


].

