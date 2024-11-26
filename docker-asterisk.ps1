function SolicitarParametro {
    param (
        [string]$mensaje
    )
    Read-Host -Prompt $mensaje
}

if (-not $args[0]) {
    Write-Host "Error: No se ha provisto ningún argumento. Por favor especifique 'image', 'container create|start|stop|asterisk|bash|sngrep'." -ForegroundColor Red
    exit 1
}

$CHAR = $args[0]

switch ($CHAR) {
    "image" {
        Write-Host "Construyendo imagen de Docker..."
        # Personaliza los archivos de configuración si es necesario aquí.
        docker build -t docker-asterisk .
    }

    "container" {
        if (-not $args[1]) {
            Write-Host "Por favor, especifique una acción: 'create', 'start', 'stop', 'asterisk', 'bash' o 'sngrep'." -ForegroundColor Red
            exit 1
        }

        $containerAction = $args[1]
        $containerName = "docker-asterisk"
        $hostPort = 5060

        switch ($containerAction) {
            "create" {
                if (docker ps -a | Select-String -Pattern $containerName) {
                    Write-Host "El contenedor 'docker-asterisk' ya existe." -ForegroundColor Yellow
                    exit 1
                }

                Write-Host "Creando contenedor 'docker-asterisk'..."
                docker run -itd --name $containerName `
                    -p "$hostPort:5060/tcp" `
                    -p "$hostPort:5060/udp" `
                    -p "10000-10010:10000-10010/udp" docker-asterisk
                Write-Host "Contenedor 'docker-asterisk' creado exitosamente."
            }
            "start" {
                if (!(docker start $containerName)) {
                    Write-Host "Error: Fallo al iniciar docker-asterisk" -ForegroundColor Red
                }
            }
            "stop" {
                if (!(docker stop $containerName)) {
                    Write-Host "Error: Fallo en detener docker-asterisk" -ForegroundColor Red
                }
            }
            "asterisk" {
                if (!(docker exec -it $containerName /usr/sbin/asterisk -rvvv)) {
                    Write-Host "Error: Falló la ejecución de asterisk -rvvv en docker-asterisk" -ForegroundColor Red
                }
            }
            "bash" {
                if (!(docker exec -it $containerName /bin/bash)) {
                    Write-Host "Error: Falló la ejecución de bash" -ForegroundColor Red
                }
            }
            "sngrep" {
                if (!(docker exec -it $containerName sngrep)) {
                    Write-Host "Error: Falló la ejecución de sngrep en docker-asterisk" -ForegroundColor Red
                }
            }
            default {
                Write-Host "Opción inválida. Por favor, especifique 'create', 'start', 'stop', 'asterisk', 'bash', o 'sngrep'." -ForegroundColor Red
                exit 1
            }
        }
    }

    default {
        Write-Host "Opción inválida. Por favor, especifique 'image' o 'container create|start|stop|asterisk|bash|sngrep'." -ForegroundColor Red
        exit 1
    }
}
