# Dudas
### P2 - Clases y Módulos - Ejercicio 8.1.5
##### `puts F.value`
F hereda de C. El método de clase `#value` se encuentra en esa herencia. Cuando se lo invoca en F, yo creo que se ejecuta en el contexto de F, por lo que la constante `VALUE` sería "F". Probémoslo [...]. Contrariamente a lo que yo pensaba, `F.value` retornó "global".

**¿QUÉ ONDA?** ¿Por qué no retornó "F"? ¿El método no se ejecuta en el contexto del objeto receptor del mensaje?
