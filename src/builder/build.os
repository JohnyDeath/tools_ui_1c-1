#Использовать cli
#Использовать "."

///////////////////////////////////////////////////////////////////////////////

Процедура ВыполнитьПриложение()
    
    Приложение = Новый КонсольноеПриложение("cli", "Сборщик проекта в бинарники", ЭтотОбъект);
    Приложение.Версия("v version","1.0.0");
    
    // Приложение.ДобавитьКоманду("cfe", "Сборка расширения", Новый СборщикРасширения);
    // // Приложение.ДобавитьКоманду("g generate", "Генерация элементов структуры приложения", Новый КомандаGenerate);
    
    Приложение.Опция("platformSource", "", "Версия платформы для выполнения сборки");
    Приложение.Опция("versionEDT", "", "Версия EDT для выполнения конвертации. Для запуска через утилиту ring");
    Приложение.Опция("exportEDT", Истина, "Определяет необходимость экспортирования исходников из проекта ЕДТ в формат конфигуратора").ТБулево();
    Приложение.Опция("deleteSourse", Истина, "Нужно ли удалять исходные файлы в формате конфигуратора после сборки");
    Приложение.Опция("cfe", Истина, "Формировать сборку в формате Расширения");
    Приложение.Опция("cf", Истина, "Формировать сборку в виде конфигурации");
    Приложение.Опция("epf", Истина, "Формировать портативную сборку");
    Приложение.УстановитьОсновноеДействие(ЭтотОбъект);
    
    Приложение.Запустить(АргументыКоманднойСтроки);
    
КонецПроцедуры // ВыполнениеКоманды()

Процедура ВыполнитьКоманду(Знач КомандаПриложения) Экспорт
    Сборщик = Новый СборщикОсновной();
    Сборщик.КаталогПлатформы = КомандаПриложения.ЗначениеОпции("platformSource");
    Значение = КомандаПриложения.ЗначениеОпции("exportEDT");
    Если Значение <> Неопределено Тогда
        Сборщик.ЭкспортироватьИсходникиИзФорматаЕДТ = Значение;
    КонецЕсли;
    Значение = КомандаПриложения.ЗначениеОпции("deleteSourse");
    Если Значение <> Неопределено Тогда
        Сборщик.УдалятьИсходныеФайлыВФорматеКонфигуратора = Значение;
    КонецЕсли;
    Значение = КомандаПриложения.ЗначениеОпции("cfe");
    Если Значение <> Неопределено Тогда
        Сборщик.СборкаРасширения = Значение;
    КонецЕсли;
    Значение = КомандаПриложения.ЗначениеОпции("cf");
    Если Значение <> Неопределено Тогда
        Сборщик.СборкаКонфигурации = Значение;
    КонецЕсли;
    Значение = КомандаПриложения.ЗначениеОпции("epf");
    Если Значение <> Неопределено Тогда
        Сборщик.СборкаПортативная = Значение;
    КонецЕсли;
    Значение = КомандаПриложения.ЗначениеОпции("versionEDT");
    Если Значение <> Неопределено Тогда
        Сборщик.ВерсияЕДТ = Значение;
    КонецЕсли;
    
    Сборщик.ВыполнитьСборку();
КонецПроцедуры

///////////////////////////////////////////////////////

// Попытка

ВыполнитьПриложение();

// Исключение

// Сообщить(ОписаниеОшибки());

// КонецПопытки;   

// Библиотеки Для использования b91bfc92abf1d819915c3c95b2f311de1c7fd4b3
// https://github.com/oscript-library/bsl-parser - для редактирования описания конфигурации и т.п.
// https://github.com/oscript-library/osparser - для редактирования модулей после сборки
// https://github.com/oscript-library/swagger - для формирования документации в свагере
// https://github.com/oscript-library/onec-repo-converter - Посмотреть пример конвертации исходников из 1С в ЕДТ
// https://github.com/oscript-library/1commands - для запуска приложух если понадобится
// https://github.com/oscript-library/v8find - для поиска нужной платформы для сборки
// https://github.com/oscript-library/cfe2cf - для конвертации расширения в конфигурацию при сборке
// https://github.com/oscript-library/workflow - для описания порядка сборки. Прикольно просто попробовать
// https://github.com/oscript-library/changelog-generate - для генерации истории изменений более простой. Интересно попробовать
// https://github.com/oscript-library/oscript-yadisk - для загрузки артефактов сборки на яндекс диск
// https://github.com/oscript-library/xml-parser- для работы с XML файлами конфы
// https://github.com/oscript-library/v8runner- для работы с конфигуратором