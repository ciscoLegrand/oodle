# Oodle

## Solución
[Solución](doc/solution.md)

## Uso de la Engine

Esta aplicación está diseñada como una Engine de Rails, lo que permite su reutilización e integración con otras aplicaciones Rails.

### Instalación

Para utilizar esta Engine en tu aplicación principal, debes incluirla en tu archivo `Gemfile` de la siguiente manera:

```ruby
gem 'oodle', path: 'github.com/ciscoLegrand/oodle.git'
```

Luego, ejecuta el comando `bundle install` para instalar la gema y montarla en tu aplicación.

En tu archivo `config/routes.rb`, monta la Engine:

```ruby
mount Oodle::Engine, at: "/oodle"
```

Esto hará que la Engine esté disponible bajo la ruta `/oodle` en tu aplicación.

### Migraciones

Por defecto el comando:

```bash
bin/rails db:migrate
```

Instalará y ejecutará las migraciones de la Engine a tu aplicación principal pero no copiará los arvhivos en tu carpeta `db/migrate`.

Para copiar las migraciones de la Engine a tu aplicación principal, utiliza el siguiente comando:

```bash
bin/rails oodle:install:migrations
```

### Invocar Modelos

Para trabajar con los modelos de la Engine dentro de tu aplicación principal, debes invocarlos utilizando el namespace correspondiente, por ejemplo:

```ruby
Oodle::Questionnaire.create(
  name: 'Nuevo Examen',
  start_date: Time.zone.now,
  end_date: Time.zone.now + 1.week,
  manager: current_user
)
```

Este ejemplo crea una nueva instancia del modelo `Oodle::Questionnaire`.

### Ejemplos de Uso

Puedes interactuar con los modelos de la misma manera que lo harías con cualquier otro modelo de ActiveRecord, siempre usando el prefijo del módulo `Oodle`.

#### Crear un Nuevo Examen

```ruby
questionnaire = Oodle::Questionnaire.create(
  name: 'Examen Final',
  start_date: '2024-10-20',
  end_date: '2024-10-27',
  manager: current_user
)
questionnaire.completion_percentage # => Proporciona el porcentaje de finalización del examen
```

#### Añadir una Pregunta a un Examen

```ruby
question = Oodle::Question.create(
  name: '¿Qué es Ruby on Rails?',
  question_type: :free_text,
  scorable: true,
  score: 10
)
questionnaire.questions << question
```

#### Crear Opciones para una Pregunta de Selección

```ruby
item1 = Oodle::Item.create(
  name: 'Framework MVC',
  description: 'Ruby on Rails es un framework MVC.',
  score: 5,
  display_value: 'Framework MVC',
  correct_value: true
)

item2 = Oodle::Item.create(
  name: 'Lenguaje de Programación',
  description: 'Ruby on Rails no es un lenguaje de programación.',
  score: 0,
  display_value: 'Lenguaje de Programación',
  correct_value: false
)

question.items << item1
question.items << item2
```

#### Crear una Respuesta para una Pregunta

```ruby
user_questionnaire = Oodle::UserQuestionnaire.find_or_create_by(
  user: current_user,
  questionnaire: questionnaire
)

answer = Oodle::Answer.create(
  user: current_user,
  question: question,
  questionnaire: questionnaire,
  result: { answer: 'Ruby on Rails es un framework MVC para aplicaciones web' }
)

# Si la pregunta es puntuable y se necesita calcular la puntuación:
selected_answers = answer.result['selected'] || []
answer.calculate_score(selected_answers, question.items)
```

#### Actualizar el Progreso del Usuario en el Cuestionario

```ruby
user_questionnaire.update_progress
```

#### Marcar el Cuestionario como Completado

```ruby
user_questionnaire.mark_as_completed
```

#### Consultar Preguntas de un Examen

```ruby
questionnaire.questions.each do |question|
  puts "Pregunta: #{question.name}, Tipo: #{question.question_type}"
end
```

#### Consultar Estadísticas de un Examen

```ruby
puts "Porcentaje de finalización: #{questionnaire.completion_percentage}%"
puts "¿Está disponible el examen?: #{questionnaire.available?}"
puts "Puntuación promedio: #{questionnaire.average_score}"
```

#### Verificar si un Usuario es Manager

```ruby
user = User.find(1)
puts "El usuario es manager: #{user.role == 'manager'}" # => true/false
```

### Estadísticas Disponibles

La Engine `Oodle` proporciona diversas métricas y estadísticas útiles para gestionar exámenes y usuarios:

- **Porcentaje de Finalización del Examen (`Oodle::Questionnaire#completion_percentage`)**: Indica cuántos usuarios han completado el examen.
- **Disponibilidad del Examen (`Oodle::Questionnaire#available?`)**: Verifica si el examen está actualmente disponible para ser tomado.
- **Puntuación Promedio del Examen (`Oodle::Questionnaire#average_score`)**: Calcula la puntuación promedio obtenida por los usuarios.
- **Progreso del Usuario (`Oodle::UserQuestionnaire#progress`)**: Muestra el porcentaje de progreso de un usuario en un examen específico.
- **Puntaje de Respuestas (`Oodle::Answer#calculate_score`)**: Calcula y asigna un puntaje basado en las respuestas proporcionadas por el usuario.
- **Dificultad de la Pregunta (`Oodle::Question#difficulty`)**: Determina la dificultad de una pregunta basada en el rendimiento de los usuarios.

Estas estadísticas permiten a los administradores y managers evaluar el rendimiento de los usuarios y la eficacia de los exámenes, proporcionando una visión detallada del proceso de aprendizaje y los resultados obtenidos.

### Notas Adicionales

- **Validaciones y Callbacks**: Los modelos incluyen validaciones para asegurar la integridad de los datos y callbacks para actualizar automáticamente el progreso y las puntuaciones.

- **Tipos de Preguntas**: El modelo `Oodle::Question` soporta tres tipos de preguntas definidos por un enum:

  - `free_text`: Pregunta de texto libre.
  - `simple`: Pregunta de selección única.
  - `multiple`: Pregunta de selección múltiple.

- **Cálculo de Puntuaciones**: El método `calculate_score` en el modelo `Oodle::Answer` se utiliza para calcular la puntuación de una respuesta basada en las opciones seleccionadas y las puntuaciones de los ítems asociados.

## License

La gema está disponible como código abierto bajo los términos de la [Licencia MIT](https://opensource.org/licenses/MIT).
