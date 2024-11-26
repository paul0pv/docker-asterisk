# **Asterisk en Docker**

## **Descripción**

Este proyecto proporciona un entorno de Asterisk utilizando Docker. Permite construir una imagen personalizada básica de Docker, ejecutar un contenedor con Asterisk y realizar diversas acciones sobre el contenedor. Es un proyecto de curso de carrera así que no se asegura actualizaciones. 
El contenido se ha basado en los blogs de Dev4telco: 

[Dockerizando Asterisk - Instalación manual](https://blog.dev4telco.mx/dockerizando-asterisk-1/)

[Dockerizando Asterisk - Dockerfile](https://blog.dev4telco.mx/dockerizando-asterisk-2/).

## **Funcionalidades**

* **Construcción de la imagen:** Crea una imagen de Docker personalizada con Asterisk y configuraciones específicas.
* **Gestión de contenedores:** Permite crear, iniciar, detener y ejecutar comandos dentro del contenedor de Asterisk. El script tiene funciones básicas que se detallan en [Uso](#uso)
* **Flexibilidad:** Ofrece opciones para personalizar la configuración de Asterisk y la ejecución del contenedor. Puedes añadir los archivos que veas necesarios para tu configuración en el directorio 'config'.

## **Requisitos Previos**

* **Docker:** (Recomendado) Asegúrate de tener Docker instalado y en funcionamiento en tu sistema.
* **Podman:** (Alterntivo) Puedes usar podman con el script 'podman-asterisk'. Te solicitará un nombre para tu contenedor y un puerto en el host.

### Estructura del Proyecto

* **docker-asterisk:** Script principal para interactuar con el proyecto.
* **config:** Directorio que contiene los archivos de configuración de Asterisk (users.conf, sip.conf, etc.).
* **Dockerfile:** Archivo de construcción de la imagen de Docker.
  
<a id="uso"></a>
### **Uso**

```bash
./docker-asterisk <comando> [argumentos]

./docker-asterisk image  # Construye la imagen de Docker de Asterisk

./docker-asterisk container create  # Crea un nuevo contenedor

./docker-asterisk container start   # Inicia el contenedor

./docker-asterisk container stop   # Detiene el contenedor

./docker-asterisk container asterisk # Ejecuta el comando asterisk -rvvv dentro del contenedor.

./docker-asterisk container bash    # Inicia un shell Bash dentro del contenedor

./docker-asterisk container sngrep    # Ejecuta sngrep dentro del contenedor para capturar tráfico
```

El script para podman (podman-asterisk) posee las mismas funciones

## ⚠️ Aviso

### **sngrep y Podman**

Puede haber incompatibilidades o problemas al utilizar sngrep con Podman en ciertas configuraciones. Se recomienda investigar y buscar soluciones específicas de ser el caso.

### **Edición de Archivos**

**¡Precaución!** Editar los archivos de configuración de Asterisk o Docker puede provocar fallos en el sistema si no se realiza correctamente. **Solo edita los archivos si tienes conocimientos avanzados y comprendes las implicaciones de tus cambios.** Si encuentras algún problema, consulta la documentación oficial o busca ayuda en comunidades especializadas.

### **Compose**

El script no ha sido adaptado para hacer uso de docker/podman compose. El proyecto tiene plantillas y líneas comentadas en el script con los que trabajar si lo deseas o lo que se acomode a tu flujo de trabajo.