## Git

### 1. Ejecutá git o git help en la línea de comandos y mirá los subcomandos que tenés disponibles.
```
   add        Add file contents to the index
   bisect     Find by binary search the change that introduced a bug
   branch     List, create, or delete branches
   checkout   Checkout a branch or paths to the working tree
   clone      Clone a repository into a new directory
   commit     Record changes to the repository
   diff       Show changes between commits, commit and working tree, etc
   fetch      Download objects and refs from another repository
   grep       Print lines matching a pattern
   init       Create an empty Git repository or reinitialize an existing one
   log        Show commit logs
   merge      Join two or more development histories together
   mv         Move or rename a file, a directory, or a symlink
   pull       Fetch from and integrate with another repository or a local branch
   push       Update remote refs along with associated objects
   rebase     Forward-port local commits to the updated upstream head
   reset      Reset current HEAD to the specified state
   rm         Remove files from the working tree and from the index
   show       Show various types of objects
   status     Show the working tree status
   tag        Create, list, delete or verify a tag object signed with GPG
```

### 2. Ejecutá el comando git help help. ¿Cuál fue el resultado?
Se abrieron las man pages de git.

### 3. Utilizá el subcomando help para conocer qué opción se puede pasar al subcomando add para que ignore errores al agregar archivos.
`git add --ignore-errors`

### 4. ¿Cuáles son los estados posibles en Git para un archivo? ¿Qué significa cada uno?
- Commited: está en el repositorio.
- Staged: está listo para ser confirmado.
- Modified: esta modificado, aún en el working directory.

### 5. Cloná el repositorio de materiales de la materia. Una vez finalizado, ¿cuál es el hash del último commit que hay en el repositorio que clonaste? Tip: git log.
d8421af65d6409ad27e460dc5e3c834e8c49ee1e

### 6. ¿Para qué se utilizan los siguientes subcomandos?
- init: inicializar un repositorio vacío en un directorio, o reinicializar uno ya existente.
- status: ver los cambios realizados sobre los archivos en el working tree.
- log: ver los logs de los commits (en el branch actual)
- fetch: obtener las historias de desarollo que aún no se "tengan" desde un repositorio remoto. O sea, obtener los cambios realizados en este repositorio remoto.
- merge: **PROFUNDIZAR**
- pull: fetch & merge.
- commit: agregar al repositorio los cambios preparados en el stage.
- stash: agrega el estado actual del working directory junto con los cambios stageados a la sección *stash*, dejando el working directory limpio. Esto se utiliza cuando se quiere cambiar de branch o de lo que sea y no se quiere commitear aún ni perder los cambios.
- push: enviar a un repositorio remoto los cambios realizados en el local.
- rm: dejar de trackear un archivo.
- checkout: tomar una cierta versión de un archivo o del proyecto y ponerla en el working directory.

### 8. Utilizá el subcomando log para ver los commits que se han hecho en el repositorio, tomá cualquiera de ellos, copiá su hash y luego utilizá el subcomando checkout para viajar en el tiempo (apuntar tu copia local) a ese commit. ¿Qué commits muestra ahora git log? ¿Qué ocurrió con los commits que no aparecen? ¿Qué dice el subcomando status?
`git log` ahora sólo muestra los commits anteriores al commit en el que estoy parado. Esto ocurre porque, desde el punto de vista de este commit, los commits siguientes no ocurrieron. El subcomando status muestra lo mismo que antes de cambiar de commit, habría que ver bien **POR QUÉ**.

### 10. Creá un directorio vacío en el raiz del proyecto clonado. ¿En qué estado aparece en el git status? ¿Por qué?
No aparece nada en el git status. Será porque los directorios vacíos no "ensucian" el working directory.

### 11. Creá un archivo vacío dentro del directorio que creaste en el ejercicio anterior y volvé a ejecutar el subcomando status. ¿Qué ocurre ahora? ¿Por qué?
Ahora sí aparece. Supongo que porque el directorio ya no está vacío.

### 12. Utilizá el subcomando clean para eliminar los archivos no versionados (untracked) y luego ejecutá git status. ¿Qué información muestra ahora?
Los archivos "no versionados" son los que no están *stageados*. `clean` elimina todos los cambios realizados sobre estos archivos, pero no toca nada de lo que ya está stageado.

### Conclusiones
- Los archivos **trackeados** son aquellos que están **stageados**. El comando `clean` elimina los cambios no *stageados*.
- `checkout` modifica el puntero HEAD. El puntero HEAD es el indicador de qué es lo que hay en el *working directory* (o qué es lo que habría si estuviera limpio).
- `stash` sirve para guardar en una pila el estado actual del working directory, permitiendo, por ejemplo, cambiar de branch sin commitear ni perder los cambios.
- `git help X` provee ayuda sobre el comando X.
- Los directorios vacíos no "ensucian" el *working tree*.