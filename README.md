# Prácticas de Organización y Gestión de Empresas - UBU

Este repositorio contiene las prácticas y proyectos realizados en la asignatura de Organización y Gestión de Empresas (4º Curso de Ingeniería Informática) en la Universidad de Burgos, finalizada con éxito en enero de 2026 (Curso 2025-2026).

## 🎓 Calificaciones y Contenido del Repositorio

He superado la asignatura holgadamente en **Primera Convocatoria** con una **calificación final en acta de 8.0 / 10** (basado en un 79,93% del total del curso). 

Para mayor transparencia, en este repositorio se adjunta un archivo Excel con el desglose completo de todas mis calificaciones (incluyendo la nota de los exámenes teóricos, cuestionarios y entregables). 

La estructura principal del repositorio es la siguiente:

* 📄 **Notas_Asignatura.xlsx**: Registro detallado de todas las calificaciones obtenidas durante el semestre.
* 📄 **GuiaDocente.pdf**: Documento oficial de la asignatura que justifica los porcentajes y pesos de evaluación utilizados en los cálculos del Excel.
* 🖼️ **Notas_Problemas_Financieros.png**: Captura con la retroalimentación detallada del profesor para la práctica de evaluación de inversiones (referenciada en el Excel).
* 📁 **PRACTICAS/**: Directorio principal que agrupa el código, los archivos y los recursos de las 6 prácticas evaluables y el proyecto competitivo extra.

---


## 🏭 Práctica 1: Algoritmo de Búsqueda Aleatoria (Flowshop)

El objetivo de esta práctica es implementar un programa que resuelva el problema de *flowshop permutacional* mediante un algoritmo de búsqueda aleatoria simple. 

El programa solicita como *input* un número de iteraciones y devuelve la mejor solución encontrada (optimizando por $Fmax$ o $Fmed$), mostrando además la secuencia óptima de tareas que la genera.

### 🏆 Resultados Académicos
* **Calificación obtenida:** 90.00 / 100.00
* **Comentario del profesor:** "Algoritmo correcto"

### ⚙️ Herramientas y Lenguaje
* **Lenguaje:** MATLAB (archivos `.m`)
* **Entorno:** MATLAB R2024b Update 5 (64-bit)

### 🚀 Instrucciones de Ejecución
Para probar el algoritmo en MATLAB, sigue estos pasos:
1. [cite_start]Ejecuta el comando principal en la consola de MATLAB: `flowshop_busqueda_aleatoria`[cite: 6].
2. El programa solicitará el nombre de un archivo de datos (que debe estar en formato `.txt`). [cite_start]Ejemplo: `ejem_clase1.txt`[cite: 6].
3. Introduce el número de iteraciones deseadas para la búsqueda aleatoria. [cite_start]Ejemplo: `30`[cite: 6].
4. [cite_start]Selecciona si deseas evaluar el algoritmo utilizando el criterio $Fmax$ o $Fmed$[cite: 6].
5. [cite_start]**Salida generada:** El programa mostrará el resultado en formato texto por consola, generará un gráfico por colores y un gráfico lineal[cite: 7].



## 📍 Práctica 2: Algoritmo de Búsqueda Local (Flowshop)

El objetivo de esta segunda práctica es resolver el problema de *flowshop permutacional* aplicando algoritmos de búsqueda local. La implementación permite utilizar estrategias basadas en "el primer mejor" (First Improvement) o "el mejor vecino" (Best Improvement) evaluando todo el vecindario. Al igual que en la práctica anterior, se busca optimizar el resultado según el criterio de $Fmax$ o $Fmed$ y devolver la secuencia que lo genera.

### 🏆 Resultados Académicos
* **Calificación obtenida:** 93.00 / 100.00
* **Comentario del profesor:** "Buen trabajo Rubén. Bien el intento de salida gráfica. Enhorabuena."

### 🚀 Instrucciones de Ejecución
Para probar esta versión del algoritmo en MATLAB, sigue estos pasos:
1. Ejecuta el comando principal en la consola de MATLAB: `flowshop_busqueda_local`.
2. El programa solicitará el nombre de un archivo de datos (ejemplo: `ejem_clase1.txt`).
3. Selecciona si deseas optimizar el algoritmo utilizando el criterio $Fmax$ o $Fmed$.
4. Introduce los parámetros avanzados de búsqueda:
   * Temperatura inicial (ejemplo: `10`).
   * Temperatura final (ejemplo: `50`).
   * Número de iteraciones por temperatura (ejemplo: `3000`).
   * Factor de enfriamiento entre 0 y 1 (ejemplo: `0.5`).
5. **Salida generada:** El programa mostrará los resultados por texto en la consola y generará tres representaciones visuales: un gráfico por colores y dos gráficos lineales.



## 🌡️ Práctica 3: Algoritmo de Recocido Simulado (Flowshop)

El objetivo de esta tercera práctica es resolver el problema de *flowshop permutacional* utilizando el algoritmo metaheurístico de Recocido Simulado (Simulated Annealing). El algoritmo evalúa soluciones vecinas y permite movimientos hacia estados peores probabilísticamente para escapar de óptimos locales, dependiendo de factores como la temperatura y el enfriamiento. Devuelve la mejor solución encontrada (optimizando $Fmax$ o $Fmed$) y la secuencia correspondiente.

Como mejora avanzada del diseño, se plantea la posibilidad de recoger la solución devuelta por este algoritmo e introducirla como solución inicial en una búsqueda local (práctica anterior) para obtener un resultado aún más pulido.

### 🏆 Resultados Académicos
* **Calificación obtenida:** 92.00 / 100.00
* **Comentario del profesor:** "Bastante bien RUbén. Recuerda que conviene exprimir la solución encadenándolo con una búsqueda local. Enhorabuena"

### 🚀 Instrucciones de Ejecución
Para probar esta versión del algoritmo en MATLAB, sigue estos pasos:
1. Ejecuta el comando principal en la consola de MATLAB: `flowshop_recocido_simulado`.
2. El programa solicitará el nombre de un archivo de datos (ejemplo: `ejem_clase1.txt`).
3. Selecciona si deseas el algoritmo por $Fmax$ o por $Fmed$.
4. Introduce los parámetros del recocido simulado:
   * Temperatura inicial (ejemplo: `10`).
   * Temperatura final (ejemplo: `50`).
   * Número de iteraciones por temperatura (ejemplo: `3000`).
   * Factor de enfriamiento entre 0 y 1 (ejemplo: `0.5`).
5. **Salida generada:** El programa mostrará los resultados por texto en consola, renderizará un gráfico por colores y dibujará dos gráficos lineales.



## 🧬 Práctica 4: Algoritmo Genético (Flowshop)

El objetivo de esta cuarta práctica es resolver el problema de *flowshop permutacional* aplicando computación evolutiva, concretamente un **Algoritmo Genético**. El desarrollo incluye todas las fases del ciclo evolutivo: representación de individuos, inicialización, evaluación del *fitness*, métodos de selección (ruleta o torneo), operadores de cruce y mutación, y criterios de reemplazo y parada.

Al igual que en prácticas anteriores, el sistema devuelve la mejor solución encontrada (optimizando por $Fmax$ o $Fmed$) y la secuencia de tareas que la genera.

### 🏆 Resultados Académicos
* **Calificación obtenida:** 94.00 / 100.00
* **Comentario del profesor:** "Rubén, muy buen trabajo. Enhorabuena"

### 🚀 Instrucciones de Ejecución
Para probar el algoritmo genético en MATLAB, sigue estos pasos:
1. Ejecuta el comando principal en la consola de MATLAB: `flowshop_algoritmo_genetico`.
2. El programa solicitará el nombre de un archivo de datos (ejemplo: `ejem_clase1.txt`).
3. Selecciona si deseas optimizar el algoritmo utilizando el criterio $Fmax$ o $Fmed$.
4. Introduce los parámetros evolutivos:
   * Tamaño de la población (ejemplo: `50`).
   * Número de generaciones (ejemplo: `20`).
   * Probabilidad de cruce (valor entre 0 y 1, ejemplo: `0.5`).
   * Probabilidad de mutación (valor entre 0 y 1, ejemplo: `0.5`).
   * Método de selección: elige entre `ruleta` o `torneo`.
5. **Salida generada:** El programa mostrará los resultados óptimos por consola, un gráfico por colores representando la solución, y dos gráficos lineales con la evolución del fitness.



## 📊 Práctica 5: MRP con una hoja de cálculo

El objetivo de esta quinta y última práctica es programar un sistema **MRP (Planificación de Requerimientos de Materiales)** completamente funcional utilizando únicamente una hoja de cálculo. 

El diseño del documento cumple con estrictas normas de diseño y estructuración de datos. La característica principal de esta implementación es su automatización absoluta: el MRP se calcula automáticamente mediante fórmulas complejas enlazadas, eliminando la necesidad de introducir datos a mano más allá de los *inputs* iniciales (como el plan maestro, el BOM o los inventarios).

### 🏆 Resultados Académicos
* **Calificación obtenida:** 92.00 / 100.00
* **Comentario del profesor:** "Práctica perfecta Rubén. Enhorabuena."

### ⚙️ Herramientas y Formato
* **Herramienta:** Microsoft Excel (Archivo `.xlsx`)
* **Contenido:** El libro contiene las pestañas de "Datos de Entrada", "LANZ PP" (Lanzamiento de Órdenes Planificadas) y "LANZ PP CAMBIOS" para analizar distintos escenarios logísticos.



## 💰 Práctica 6: Problemas Financieros (Evaluación de Inversiones)

El objetivo de esta entrega es la resolución de 7 problemas financieros complejos orientados a la evaluación y selección de proyectos de inversión. 

Se evalúan distintos escenarios calculando los Flujos Netos de Caja, el Desembolso Inicial, el Valor Actual Neto (VAN), la Tasa Interna de Rentabilidad (TIR), el Índice de Rentabilidad y el Plazo de Recuperación (Payback). 

Siguiendo las instrucciones del proyecto, toda la hoja de cálculo está fuertemente automatizada mediante fórmulas. Si se modifican los datos de entrada (como la tasa de descuento o los cobros/pagos de un año concreto), todos los indicadores de viabilidad financiera se actualizan en tiempo real.

### 🏆 Resultados Académicos
* **Calificación obtenida:** 92.00 / 100.00
* **Comentario del profesor:** "Buen trabajo"

### ⚙️ Herramientas y Formato
* **Herramienta:** Microsoft Excel (Archivo `.xlsx`)
* **Contenido:** El documento consta de 7 pestañas distintas (P1 a P7), una para cada problema de inversión resuelto.



## 🏆 Proyecto Extra: Optimization Contest (OptContest)

[cite_start]Participación en el concurso voluntario de *Scheduling y Optimización Heurística* organizado por los profesores de la asignatura[cite: 6, 7]. [cite_start]Bajo el nombre de equipo **"Los Trifuerza" (A6)**, el objetivo del torneo fue diseñar un algoritmo competitivo capaz de minimizar el valor $Fmed$ en un problema de *flowshop permutacional* masivo (20 máquinas y 75 órdenes)[cite: 9, 10, 18]. 

[cite_start]El reto exigía una optimización de código extrema, ya que el tiempo máximo de ejecución por prueba estaba estrictamente limitado a 1 minuto de CPU, penalizando cualquier exceso de tiempo[cite: 16, 17]. El algoritmo se midió en un ranking global contra las implementaciones de otros alumnos y profesores, los cuales utilizaban lenguajes de alto rendimiento como C, Rust, Cython y Java.

### 🏆 Resultados del Torneo
* **Puntuación competitiva:** 0.30 / 1.00 (Basado en la posición del ranking global).
* **Rendimiento:** El algoritmo superó exitosamente el umbral de la búsqueda aleatoria de 10.000 iteraciones y venció a múltiples equipos rivales.

### 🚀 Instrucciones de Ejecución
El programa está diseñado para ser rápido y automatizado:
1. [cite_start]En la consola de MATLAB, ejecuta el comando: `[Fmed, tiempo, secuencia] = optcontestA6('test.txt')`[cite: 36, 39].
2. [cite_start]También soporta ejecución sin parámetros interactivos: `optcontestA6()`[cite: 36, 39].
3. [cite_start]**Salidas:** El programa muestra por pantalla el progreso, devuelve el valor óptimo de $Fmed$, el tiempo de CPU consumido y la secuencia[cite: 12, 38]. 
4. [cite_start]Adicionalmente, genera un archivo `.txt` automático (ej: `resultados_test.txt_20251219_035111.txt`) para guardar el registro de la ejecución[cite: 40].