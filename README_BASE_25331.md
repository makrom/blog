Simple mailing blog Краткая инструкция по установке и запуску приложения.

Установить Ruby on Rails (в проекте используется версия Ruby 2.6.3p62 и Rails 5.2.3)
Для работы приложения используется sidekiq и sidekiq-cron (ничего на эту тему раньше не знал поэтому долго пришлось читать и настраивать), работающий через redis, поэтому необходимо установить redis последней версии (но не ниже 3.0.3). Возможно запустить приложение на Heroku.
Из папки приложения blog_app в одном окне терминала запускается sidekiq (тут же можно будет наблюдать запуск рассылок по расписанию: для тестирования можно до запуска sidekiq раскомментарить строки в файле config/schedule.yml и закомментарить текущие, при этом ежедневная рассылка будет происходить каждую минуту, а еженедельная - каждые 5 минут), в другом окне запускаем сервер rails s.
В браузере, как обычно, переходим по адресу http://localhost:3000/
При регистрации станет досупной ссылка Управление блогом, где можно добавлять, удалять и т.д. новости.
Если новостей за период нет, то рассылка пустых писем не происходит.
Для тестирования используется RSpec. Тестов написано 2: rspec spec/models/post_spec.rb - для тестирования модели Post (это первый мой самостоятельный тест) и rspec spec/mailers/post_mailer_spec.rb - для тестирования отправки почтовых сообщений рассылки.
п.3.5 и 3.7 из Т.З. для меня новые, реализую в ближайшее время, о чем можно будет узнать, когда этот текст пропадет. Спасибо за хорошую задачу. Роман Макаров