# genpy
**genpy** es un plugin para oh-my-zsh que me ayuda a generar de manera automatica la estructura para un proyecto simple en Python.

Ejemplo:
.
├── bin
│   └── test
├── README.md
├── requirements.txt
└── setup.py

1 directory, 4 files

## Usage:
Solo debe ejecutar el comando `genpy` e ingresar los datos generales del proyecto.

```
blessx@jalil[/tmp]:genpy
name project: test
description: this is a test
version: v1.0
author: blessxjalil
generate new project: test
[+] generate README.md
[+] generate setup.py
[+] generate requirements.txt
[+] generate bin/test
the project has been created!
project: /tmp/test
```
