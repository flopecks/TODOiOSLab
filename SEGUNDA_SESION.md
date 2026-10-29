# Preparación — Mis tareas sobreviven

Este laboratorio parte de la rama **`lab-swiftdata-filtros`**. El proyecto inicial compila y contiene ejercicios pequeños para completar siguiendo la [guía paso a paso](codelab/swiftdata-filtros.html).

## Obtén la base del laboratorio

Desde tu clon del fork, ejecuta `git status` y guarda cualquier cambio pendiente en tu rama anterior. Comprueba con `git remote -v` que origin apunta a tu fork. Sustituye `tu-alias` por un nombre propio sin espacios y ejecuta:

```bash
git fetch https://github.com/franzueto/TODOiOSLab.git lab-swiftdata-filtros
git switch -c lab/swiftdata-tu-alias FETCH_HEAD
open codelab/swiftdata-filtros.html
open TODOiOSLab.xcodeproj
```

Ejecuta switch inmediatamente después de fetch: `FETCH_HEAD` representa la rama que acabas de descargar. No necesitas que esa rama ya exista en tu fork ni cambiar origin. Tu trabajo anterior permanece en su rama. Si el nombre de rama de trabajo ya existe, elige uno nuevo, por ejemplo con sufijo `-2`.

## Antes de ejecutar

Selecciona el esquema TODOiOSLab y un simulador iOS ya instalado, o un iPhone previamente preparado. Mantén usesPersistence = true.

Xcode 27.1, tu clon y tu acceso a GitHub deben estar preparados. No hay paquetes externos que instalar. La guía y la app funcionan offline; GitHub requiere internet para obtener la rama y entregar el trabajo.

## Entrega

Trabaja en tu rama `lab/swiftdata-tu-alias`, guarda al menos dos commits propios y abre un PR nuevo hacia **main de tu fork**, con las capturas indicadas por la guía. El diff puede incluir la base preparada; explica cuáles son tus cambios personales.

Si GitHub carga la plantilla anterior, reemplaza la descripción con el contenido de `.github/pull_request_template.md` de tu rama actual. Deja el PR abierto, comparte su enlace y revoca tu token temporal al terminar.
