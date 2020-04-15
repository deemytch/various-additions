# Полезные дополнения к стандартным классам

которые не monkey-patch.

## QueueWithTimeout

Queue, который ждёт таймаута.

## Checksum

* inn?( String )
    
  Проверка корректности ИНН

* okpo?( String )

  Проверка правильности ОКПО

* orgn?( String )

  Проверка правильности OГРН

* addr_or_name?( String )
  
  Если есть слова из букв и длина больше 10, то может быть это что-то значимое.

## Checkers

For checking the list of timeouts.

Argument `models` could be any database model, that supports `created_at` method, or Date, DateTime or Integer as unix time.

Returns boolean.

* Any of models is reached timeout?

        tmout_any?( tlast, *models )

* All of models are reached timeout?

        tmout_all?( tlast, *models )
