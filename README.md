# Choppi App

Aplicación móvil desarrollada con Flutter para la plataforma Choppi.

## Requisitos Previos

Antes de comenzar, asegúrate de tener instalado:

- **Flutter SDK** (versión 3.9.2 o superior)
  - Puedes descargarlo desde [flutter.dev](https://flutter.dev/docs/get-started/install)
  - Verifica la instalación ejecutando: `flutter doctor`
- **Dart SDK** (incluido con Flutter)
- **Android Studio** o **VS Code** con extensiones de Flutter
- **Android SDK** (para desarrollo Android)
- **Java JDK** (versión 11 o superior)

## Instalación

1. Clona el repositorio:

```bash
git clone <url-del-repositorio>
cd choppi_app
```

2. Instala las dependencias:

```bash
flutter pub get
```

3. Verifica que todo esté configurado correctamente:

```bash
flutter doctor
```

## Variables de Entorno

El proyecto utiliza archivos de entorno para gestionar las configuraciones según el ambiente (desarrollo o producción).

### Archivos de Entorno

El proyecto incluye dos archivos de entorno en la carpeta `assets/`:

- `assets/env.development` - Configuración para desarrollo local
- `assets/env.production` - Configuración para producción

### Variables Disponibles

- **ENDPOINT**: URL base del backend API

### Configuración de Variables de Entorno

#### Desarrollo

Edita el archivo `assets/env.development` con tu configuración local:

```env
ENDPOINT=http://192.168.0.181:3000
```

**Nota:** Asegúrate de usar la IP de tu máquina local o `localhost` si estás ejecutando en un emulador.

#### Producción

Edita el archivo `assets/env.production` con la URL de producción:

```env
ENDPOINT=https://choppi-back.onrender.com
```

### Cómo Funciona

El proyecto carga automáticamente el archivo de entorno según el modo de ejecución:

- **Modo Debug** (desarrollo): Carga `assets/env.development`
- **Modo Release** (producción): Carga `assets/env.production`

La configuración se maneja en `lib/config/app_config.dart` y se inicializa al iniciar la aplicación.

## Ejecutar el Proyecto en Local

### 1. Verificar Dispositivos Conectados

Lista los dispositivos disponibles (emuladores o dispositivos físicos):

```bash
flutter devices
```

### 2. Ejecutar en Modo Desarrollo

Para ejecutar la aplicación en modo desarrollo (debug):

```bash
flutter run
```

O si tienes múltiples dispositivos, especifica el dispositivo:

```bash
flutter run -d <device-id>
```

### 3. Ejecutar en Modo Release (Local)

Para ejecutar en modo release (usa las variables de producción):

```bash
flutter run --release
```

### 4. Hot Reload y Hot Restart

Durante el desarrollo, puedes usar:

- **Hot Reload**: Presiona `r` en la terminal o el botón de recarga en tu IDE
- **Hot Restart**: Presiona `R` en la terminal
- **Quit**: Presiona `q` en la terminal

## Crear APK

### APK de Debug

Para crear una APK de debug (para testing):

```bash
flutter build apk --debug
```

El archivo APK se generará en:

```
build/app/outputs/flutter-apk/app-debug.apk
```

### APK de Release

Para crear una APK de release (para distribución):

```bash
flutter build apk --release
```

El archivo APK se generará en:

```
build/app/outputs/flutter-apk/app-release.apk
```

### APK Dividida por ABI (Recomendado)

Para crear APKs optimizadas por arquitectura (reduce el tamaño del archivo):

```bash
flutter build apk --split-per-abi
```

Esto generará tres archivos APK separados:

- `app-armeabi-v7a-release.apk` (32-bit)
- `app-arm64-v8a-release.apk` (64-bit)
- `app-x86_64-release.apk` (x86_64)

### APK Bundle (AAB) para Google Play

Si vas a publicar en Google Play Store, es recomendable crear un Android App Bundle:

```bash
flutter build appbundle --release
```

El archivo AAB se generará en:

```
build/app/outputs/bundle/release/app-release.aab
```

## Estructura del Proyecto

```
choppi_app/
├── android/          # Configuración específica de Android
├── ios/              # Configuración específica de iOS
├── lib/              # Código fuente de la aplicación
│   ├── auth/         # Autenticación y rutas protegidas
│   ├── config/       # Configuración de la app
│   ├── services/     # Servicios de la aplicación
│   └── views/        # Pantallas/vistas
├── assets/           # Recursos y archivos de entorno
│   ├── env.development
│   └── env.production
└── pubspec.yaml      # Dependencias del proyecto
```

## Solución de Problemas

### Error: "ENDPOINT no está configurado"

Asegúrate de que:

1. Los archivos de entorno existen en `assets/`
2. Los archivos están declarados en `pubspec.yaml` (ya están incluidos)
3. Has ejecutado `flutter pub get` después de modificar `pubspec.yaml

### Error al construir APK

1. Verifica que tienes todas las dependencias instaladas:

```bash
flutter pub get
```

2. Limpia el proyecto:

```bash
flutter clean
flutter pub get
```

3. Verifica la configuración de Android:

```bash
flutter doctor -v
```

### Problemas con Variables de Entorno

Si las variables de entorno no se cargan correctamente:

1. Verifica que los archivos `.env` están en `assets/`
2. Asegúrate de que `pubspec.yaml` incluye los archivos en la sección `assets:`
3. Reinicia la aplicación completamente (no solo hot reload)

## Comandos Útiles

```bash
# Ver información del entorno Flutter
flutter doctor

# Limpiar el proyecto
flutter clean

# Actualizar dependencias
flutter pub upgrade

# Ver dispositivos disponibles
flutter devices

# Ejecutar tests
flutter test

# Analizar el código
flutter analyze
```

## Dependencias Principales

- `flutter_secure_storage`: Almacenamiento seguro de datos
- `http`: Cliente HTTP para peticiones API
- `flutter_dotenv`: Gestión de variables de entorno
- `page_transition`: Transiciones entre pantallas
- `simple_animations`: Animaciones simples

## Licencia

[Especificar licencia si aplica]
