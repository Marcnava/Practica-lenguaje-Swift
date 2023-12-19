# SEGUNDA PRÁCTICA DEL BOOTCAMP MOBILE EN *KEEPCODING*
## Lenguaje Swift

<details>
  <summary>Contenidos</summary>
  <ol>
    <li><a href="#tecnologías-utilizadas">Stack - Tecnologías utilizadas</a></li>
    <li><a href="#qué-he-aprendido">Qué he aprendido</a></li>
    <li><a href="#objetivo">Objetivo práctica</li>
    <li><a href="#agradecimientos">Agradecimientos</a></li>
  </ol>
</details>

---
### Tecnologías utilizadas
![Static Badge](https://img.shields.io/badge/swift%20-%20white?style=for-the-badge&logo=swift&logoColor=white&color=f05038)
![Static Badge](https://img.shields.io/badge/swift_playgrounds-white?style=for-the-badge&logo=swift&logoColor=f05038)
![Static Badge](https://img.shields.io/badge/xcode-188de8?style=for-the-badge&logo=xcode&logoColor=white)


---
### Qué he aprendido

Ideas clave:

- Acercamiento al lenguaje Swift y a Xcode, concretamente a Playgrounds.

- En cuanto a Swift he aprendido los siguientes conceptos:
  - Tipos de datos básicos (conversión de tipos, validación de tipos)
  - Colecciones
  - Operaciones lógicas básicas (condicionales, bucles)
  - Funciones, enumerados
  - Estructuras, clases
  - Valores opcionales
  - Control de acceso
  - Extensiones, propiedades
  - Delegados, protocolos
  - Closures
  - Código genérico
  - Herencia
  - Control de errores
  - Manejo de memoria
  - Tests unitarios (assert)
  - Singletone

- En cuanto a Xcode he aprendido a desarrollar playgrounds y debuguear.

---
### Objetivo

En esta práctica debo realizar un programa capaz de gestionar reservas para un hotel.

Crear una lista de reservas, añadir todas las reservas que se quiera, eliminar reservas de la lista y mostrar lista de reservas si la hay.

Tiene que haber un control de errores para evitar hacer reservas con clientes o IDs de reserva duplicados y eliminar una reserva cuyo ID no existe.

He de implantar una batería de tests que comprueben el buen funcionamiento del programa.

#### Contiene

- Estructuras para los clientes y las reservas.
- Enumerado para el control de errores.
- Clase que controla las funciones del programa.

Dentro de la clase hay:
- Función para añadir reservas a una lista, calcular precios según parámetros de entrada y asignar un ID autoincremental. Devuelve error si detecta clientes/IDs de reserva ya registrados.
- Función para anular reservas eliminándolas de la lista según la ID que se le pase. Devuelve error si la ID pasada no está en la lista de reservas.
- Propiedad para mostrar las reservas que hay en la lista, si hay alguna.

- Batería de test que comprueban el buen funcionamiento de las funciones y del control de errores.

---
### Agradecimientos

Agradecer al profesor por sus excelentes clases.

- **Daniel**

<a href="https://github.com/illescasDaniel" target="_blank"><img alt="Static Badge" src="https://img.shields.io/badge/github-black?style=for-the-badge&logo=github&logoColor=white">
