&НаСервере
Процедура ЗаполнитьТаблицуКонстант()

	УстановитьПривилегированныйРежим(Истина);

	ТаблицаКонстант.Очистить();

	Для Каждого Константа ИЗ Метаданные.Константы Цикл

		НоваяСтрока = ТаблицаКонстант.Добавить();
		НоваяСтрока.ИмяКонстанты = Константа.Имя;
		НоваяСтрока.СинонимКонстанты = Константа.Синоним;
		НоваяСтрока.ОписаниеТипов = Константа.Тип;
		//СтруктураФОпция = ПолучитьФункциональнуюОпциюКонстанты(СоставнойТип.Имя);
		//НоваяСтрока.ФОпция = СтруктураФОпция.ИмяФОпции;
		//НоваяСтрока.ПривилегированныйРежимПриПолучении = СтруктураФОпция.ПривилегированныйРежимПриПолучении;
		НоваяСтрока.ЗначениеКонстанты = Константы[Константа.Имя].Получить();
		НоваяСтрока.ЕстьХранилищеЗначения = Константа.Тип.СодержитТип(Тип("ХранилищеЗначения"));

		ТипЗначенияКонстанты = новый ОписаниеТипов(Константа.Тип, , "ХранилищеЗначения");
		Если ТипЗначенияКонстанты.Типы().Количество() = 0 Тогда
			НоваяСтрока.ТолькоХранилищеЗначений = Истина;
		КонецЕсли;

	КонецЦикла;

	//Заполним функциональные опции констант
	Для Каждого ФОпция ИЗ Метаданные.ФункциональныеОпции Цикл
		Если НЕ Метаданные.Константы.Содержит(ФОпция.Хранение) Тогда
			Продолжить;
		КонецЕсли;

		СтруктураПоиска = Новый Структура;
		СтруктураПоиска.Вставить("ИмяКонстанты", ФОпция.Хранение.Имя);

		НайденныеСтроки = ТаблицаКонстант.НайтиСтроки(СтруктураПоиска);
		Если НайденныеСтроки.Количество() = 0 Тогда
			Продолжить;
		КонецЕсли;

		НайденныеСтроки[0].ФОпция = ФОпция.Имя;
		НайденныеСтроки[0].ПривилегированныйРежимПриПолучении = ФОпция.ПривилегированныйРежимПриПолучении;
	КонецЦикла;

КонецПроцедуры

Процедура ВывестиЭлементыКонстантНаФорму()
	МассивДобавляемыхРеквизитов = Новый Массив;

	Для Каждого ТекКонстанта ИЗ ТаблицаКонстант Цикл
		ТипЗначенияКонстанты = ТекКонстанта.ОписаниеТипов;
		Если ТекКонстанта.ЕстьХранилищеЗначения
				И ТекКонстанта.ТолькоХранилищеЗначений Тогда
			ТипЗначенияКонстанты = Новый ОписаниеТипов("Строка");
		КонецЕсли;

		НовыйРеквизит = Новый РеквизитФормы(ТекКонстанта.ИмяКонстанты, ТипЗначенияКонстанты, "", ТекКонстанта.СинонимКонстанты, Истина);
		МассивДобавляемыхРеквизитов.Добавить(НовыйРеквизит);
	КонецЦикла;

	ИзменитьРеквизиты(МассивДобавляемыхРеквизитов, );

	//Теперь выводим на форму контанту с описанием
	ГруппаКонстант = Элементы.ГруппаКонстант;

	Для Каждого ТекКонстанта ИЗ ТаблицаКонстант Цикл
	//Делаем группу под каждую константу, чтобы ее можно было разрисовывать
		ОписаниеГруппы = УИ_РаботаСФормами.НовыйОписаниеГруппыФормы();
		ОписаниеГруппы.Имя = "Группа_" + ТекКонстанта.ИмяКонстанты;
		ОписаниеГруппы.Заголовок = ТекКонстанта.СинонимКонстанты;
		ОписаниеГруппы.Группировка = ГруппировкаПодчиненныхЭлементовФормы.Горизонтальная;
		ОписаниеГруппы.ОтображатьЗаголовок = Ложь;
		ОписаниеГруппы.Родитель = ГруппаКонстант;

		ГруппаТекущейКонстанты = УИ_РаботаСФормами.СоздатьГруппуПоОписанию(ЭтотОбъект, ОписаниеГруппы);

		ОписаниеЭлемента = УИ_РаботаСФормами.НовыйОписаниеРеквизитаЭлемента();
		ОписаниеЭлемента.СоздаватьРеквизит = Ложь;
		ОписаниеЭлемента.СоздаватьЭлемент = Истина;
		ОписаниеЭлемента.Имя = ТекКонстанта.ИмяКонстанты;
		ОписаниеЭлемента.Заголовок = ТекКонстанта.СинонимКонстанты;
		ОписаниеЭлемента.ПутьКДанным = ТекКонстанта.ИмяКонстанты;
		ОписаниеЭлемента.Вставить("ПутьКРеквизиту", ТекКонстанта.ИмяКонстанты);
		ОписаниеЭлемента.РодительЭлемента = ГруппаТекущейКонстанты;

		Если (ТекКонстанта.ОписаниеТипов.Типы().Количество() = 1
				И ТекКонстанта.ОписаниеТипов.СодержитТип(Тип("Булево"))) Тогда
			ОписаниеЭлемента.Параметры.Вставить("Вид", ВидПоляФормы.ПолеФлажка);
		КонецЕсли;
		Если ТекКонстанта.ЕстьХранилищеЗначения Тогда
			ОписаниеЭлемента.Параметры.Вставить("Доступность", Ложь);
		КонецЕсли;

		ОписаниеЭлемента.Действия.Вставить("ПриИзменении", "КонстантаПриИзменении");

		УИ_РаботаСФормами.СоздатьЭлементПоОписанию(ЭтотОбъект, ОписаниеЭлемента);
	КонецЦикла;

КонецПроцедуры

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	ЗаполнитьТаблицуКонстант();
	ВывестиЭлементыКонстантНаФорму();
	УстановитьЗначенияКонстантВРеквизитыФормы();
КонецПроцедуры

&НаСервере
Процедура УстановитьЗначенияКонстантВРеквизитыФормы()
	Для Каждого ТекКонстанта ИЗ ТаблицаКонстант Цикл
		ЭтотОбъект[ТекКонстанта.ИмяКонстанты]=ТекКонстанта.ЗначениеКонстанты;
		Элементы["Группа_" + ТекКонстанта.ИмяКонстанты].ЦветФона=Новый Цвет;
	КонецЦикла;	
КонецПроцедуры

&НаСервере
Процедура ЗаписатьНаСервере()
	УстановитьПривилегированныйРежим(Истина);

	ВсеУспешно = Истина;
	Для Каждого СтрокаКонстанты ИЗ ТаблицаКонстант Цикл
		Если Не СтрокаКонстанты.Изменено Тогда
			Продолжить;
		КонецЕсли;
		Если СтрокаКонстанты.ЕстьХранилищеЗначения Тогда
			Продолжить;
		КонецЕсли;
		
		МенеджерКонстанты=Константы[СтрокаКонстанты.ИмяКонстанты].СоздатьМенеджерЗначения();
		МенеджерКонстанты.Прочитать();
		МенеджерКонстанты.Значение=ЭтотОбъект[СтрокаКонстанты.ИмяКонстанты];
		
		Попытка
			МенеджерКонстанты.Записать();
			СтрокаКонстанты.Изменено = Ложь;

			//Установим цвет измененной константы на группу
			ЭлементГруппа = Элементы["Группа_" + СтрокаКонстанты.ИмяКонстанты];
			ЭлементГруппа.ЦветФона = Новый Цвет();

		Исключение
			Сообщить(ОписаниеОшибки());
			ВсеУспешно = Ложь;
		КонецПопытки;
	КонецЦикла;

	Если ВсеУспешно Тогда
		ЭтотОбъект.Модифицированность = Ложь;
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ПрочитатьКонстанты()
	ЗаполнитьТаблицуКонстант();
	УстановитьЗначенияКонстантВРеквизитыФормы();
	Модифицированность=Ложь;
КонецПроцедуры

&НаКлиенте
Функция ЕстьИзмененныеКонстанты()
	ЕстьИзменения=Ложь;
	ДЛя Каждого СтрокаКонстанты ИЗ ТаблицаКонстант Цикл
		Если СтрокаКонстанты.Изменено Тогда
			ЕстьИзменения=Истина;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Возврат ЕстьИзменения;
КонецФункции

&НаКлиенте
Процедура Перечитать(Команда)
	Если ЕстьИзмененныеКонстанты() Тогда
		ПоказатьВопрос(Новый ОписаниеОповещения("ПеречитатьЗаверешение", ЭтотОбъект), "Есть измененные константы. Произвести запись перед чтением?",РежимДиалогаВопрос.ДаНетОтмена);
	Иначе
		ПрочитатьКонстанты();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПеречитатьЗаверешение(Результат,ДополнительныеПараметры) Экспорт
	Если Результат=КодВозвратаДиалога.Отмена Тогда
		Возврат;
	ИначеЕсли Результат=КодВозвратаДиалога.Да Тогда
		ЗаписатьНаСервере();
	КонецЕсли;
	
	ПрочитатьКонстанты();
КонецПроцедуры

&НаКлиенте
Процедура ЗаписатьКонстанты(Команда)
	ЗаписатьНаСервере();
КонецПроцедуры

//@skip-warning
&НаКлиенте
Процедура КонстантаПриИзменении(Элемент)
	ИмяКонстанты = Элемент.Имя;

	//Установим цвет измененной константы на группу
	ЭлементГруппа = Элементы["Группа_" + ИмяКонстанты];
	ЭлементГруппа.ЦветФона = WebЦвета.БледноБирюзовый;

	СтруктураПоиска = Новый Структура;
	СтруктураПоиска.Вставить("ИмяКонстанты", ИмяКонстанты);

	НайденныеСтроки = ТаблицаКонстант.НайтиСтроки(СтруктураПоиска);
	Для Каждого Константа ИЗ НайденныеСтроки Цикл
		Константа.Изменено = Истина;
	КонецЦикла;
КонецПроцедуры
