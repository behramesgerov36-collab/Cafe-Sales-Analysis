# Cafe Sales: Data Cleaning and Analysis

Kaggle-dan götürülmüş çirkli kafe satışları datasının Excel-də təmizlənməsi, pivot ilə təhlili və SQL ilə yoxlanması.

## Məqsəd

10 000 əməliyyatlıq çirkli datanı təmizləmək və biznes suallarına cavab tapmaq: hansı məhsul ən çox gəlir gətirir, gəlir aylar üzrə necə dəyişir, müştərilər necə ödəyir, gəlirə kim töhfə verir (kiçik, yoxsa böyük əməliyyatlar).

**Dataset:** [Cafe Sales - Dirty Data for Cleaning Training]([https://www.kaggle.com/datasets/ahmedmohamed2003/cafe-sales-dirty-data-for-cleaning-training])

## Alətlər

- **Excel:** təmizləmə, PivotTable, PivotChart, Summary və Cleaning Log
- **SQL (SQLite):** `GROUP BY`, subquery, `CASE WHEN`, `ROUND`, tarix funksiyaları

## İş addımları

1. **Təmizləmə (Excel).** `ERROR`, `UNKNOWN` və boş dəyərlər işləndi. Nöqtəli ondalıq rəqəmlər (məsələn `1,5`) Excel-də tarixə çevrilmişdi, onlar bərpa olundu. Hesablana bilən boşlar `Quantity × Price Per Unit = Total Spent` düsturu ilə dolduruldu. Hər addım `Cleaning_Log` sheet-indədir.
2. **Təhlil (Excel pivotları).** 7 sual cavablandı, nəticələr `Summary` sheet-indədir.
3. **Yoxlama və əlavə təhlil (SQL).** Təmiz data SQLite-a import olundu, əsas nəticələr SQL ilə təkrar hesablandı və Excel ilə üst-üstə düşdüyü təsdiqləndi (10 000 sətir, 88 952 ümumi gəlir).


## SQL ilə cavablandırılan suallar

| # | Sual | Əsas texnika |
|---|---|---|
| 1 | Məhsul üzrə gəlir | `GROUP BY`, `SUM`, `COUNT` |
| 2 | Aylıq gəlir | `substr`, `WHERE ... IS NOT NULL` |
| 3 | Ödəniş üsulu üzrə gəlir və pay | subquery |
| 4 | Məkan üzrə müqayisə | `AVG`, `ROUND`, subquery |
| 5 | Əməliyyatın məbləğ kateqoriyası | `CASE WHEN` |

## Əsas nəticələr

- **Ən çox gəlir:** Salad (17 320). Ən çox satılan məhsul (say): Coffee (3 536 ədəd), amma gəliri aşağıdır, çünki qiyməti ucuzdur.
- **Aylar:** ən yüksək gəlir İyun (7 350), ən aşağı Fevral (6 633,5). Aylar arasında fərq kiçikdir.
- **Ödəniş üsulları:** Credit Card, Digital Wallet və Cash arasında gəlir fərqi cəmi 0,3%-dir (təxminən 20,4 min hər biri).
- **Məkan:** In-store 27 127, Takeaway 26 487,5. Fərq 2,4%-dir, orta əməliyyat məbləği demək olar ki, eynidir (8,99 və 8,76).
- **Əməliyyat ölçüsü:** əməliyyatların 56,7%-i kiçikdir (≤ 8), amma gəlirin yalnız 28,8%-ni verir. Gəlirin ən böyük payı (37,5%) orta əməliyyatlardan (8–15) gəlir.

## Məhdudiyyətlər

- Ödəniş üsulunun 31,8%-i, məkanın 39,6%-i naməlumdur (`UNKNOWN`), buna görə bu sahələr üzrə nəticələr qismən etibarlıdır.
- Tarixi boş olan 460 əməliyyat (4,6%) aylıq təhlildən çıxarılıb.
- 40 əməliyyatda `total_spent = 0` var (miqdar və ya qiymət 0 olduğu üçün). Bunlar "kiçik əməliyyat" kateqoriyasına düşür.

## Fayl strukturu

```
├── excel/excel_real_layihe.xlsx
├── sql/
│   ├── 01_analysis.sql
│ 
└── screenshots/
```
