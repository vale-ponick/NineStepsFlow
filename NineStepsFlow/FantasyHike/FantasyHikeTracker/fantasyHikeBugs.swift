//
//  fantasyHikeBugs.swift
//  NineStepsFlow
//
//  Created by Валерия Пономарева on 25.10.2026.
//

import Foundation


 // MARK: - "📋 ТЗ: «Fantasy Hike Bugs — фантомные километры»

/**
 ## 🎬 Сюжет
Ты идёшь к Роковой горе в Fantasy Hike. Пройдено 100 км из 800.
Ты садишься за руль, но на Apple Watch намеренно включаешь режим
тренировки «Ходьба» — чтобы быстрее добраться. Часы из-за вибрации
руля насчитывают лишние 5 км. Эти данные попадают в общий счётчик.

Вопрос: увидит ли iPhone эти «фантомные» километры, если оба
устройства «смотрят» на один счётчик? И что это значит для
честности прогресса?

## 🛠 Задача
Создать модель Journey (struct и class) с полем distanceKm: Double.
Написать simulatePhantomKm(), которая имитирует чит: Watch добавляет
5 км, iPhone должен показать, видит ли он их. Сравнить struct vs class.

## 🧩 Модели
- struct JourneyStruct { var distanceKm: Double }
- class JourneyClass {
      var distanceKm: Double
      init(distanceKm: Double) { self.distanceKm = distanceKm }
  }

## 🚀 Функции

### func simulatePhantomKmStruct() -> (watch: Double, iphone: Double)
- var iphoneJourney = JourneyStruct(distanceKm: 100)
- var watchJourney = iphoneJourney      // копия
- watchJourney.distanceKm += 5           // чит: часы насчитали 5 км
- return (watchJourney.distanceKm, iphoneJourney.distanceKm)

### func simulatePhantomKmClass() -> (watch: Double, iphone: Double)
- let iphoneJourney = JourneyClass(distanceKm: 100)
- let watchJourney = iphoneJourney      // ссылка на один объект
- watchJourney.distanceKm += 5           // чит
- return (watchJourney.distanceKm, iphoneJourney.distanceKm)

## ✅ Критерий «готово»
- struct: Watch 105 / iPhone 100  → прогресс «разошёлся»
- class:  Watch 105 / iPhone 105  → чит сработал на обоих

## 💡 Вопросы (ответить в комментарии)
1. Struct: iPhone 100, Watch 105 — прогресс «разошёлся». Честно?
   Что увидит игрок, открыв приложение на телефоне?
2. Class: iPhone 105, Watch 105 — прогресс «синхронизирован».
   Чит сработал на обоих. Честно?
3. Какой вариант — struct или class — правильный для Fantasy Hike,
   где цель — дойти до Роковой горы?
4. Как в реальном коде защититься от фантомных километров,
   используя знания о value/reference semantics?
*/
