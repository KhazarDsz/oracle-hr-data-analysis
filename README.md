# Oracle HR Data Analysis

Oracle HR nümunə bazasından istifadə edərək SQL ilə işçilər, maaşlar, vəzifələr və departamentlər üzrə kiçik analiz layihəsi.

Bu layihəni SQL mövzularını praktika etmək və öyrəndiklərimi bir yerdə toplamaq üçün hazırlamışam.

## İstifadə olunan alətlər

- Oracle Database
- Oracle SQL
- Oracle HR Sample Schema
- Oracle SQL Developer

## İstifadə olunan cədvəllər

- `HR.EMPLOYEES` — işçilər
- `HR.DEPARTMENTS` — departamentlər
- `HR.JOBS` — vəzifələr
- `HR.LOCATIONS` — şəhər və ünvan məlumatları

## Layihədəki 10 əsas tapşırıq

1. Maaşı 5000-dən çox olan işçiləri tapmaq.
2. Departamentlər üzrə işçi sayını hesablamaq.
3. Departamentlər üzrə orta maaşı tapmaq.
4. Ən yüksək maaş alan 5 işçini göstərmək.
5. Maaşı 5000-dən çox olan işçiləri departament adı ilə göstərmək.
6. Departamenti olmayan işçiləri tapmaq.
7. Vəzifələr üzrə işçi sayını hesablamaq.
8. Şəhərlər üzrə işçi sayını hesablamaq.
9. Hər departamentdə ən yüksək maaş alan işçini və ya işçiləri tapmaq.
10. `ROW_NUMBER()` ilə hər departamentdə ən yüksək maaş alan ilk 3 işçini göstərmək.

## Əlavə sorğular

Əsas 10 tapşırığa əlavə olaraq bu sorğuları da daxil etmişəm:

- Hər vəzifə üzrə ən yüksək maaş alan işçi və ya işçilər.
- Öz departamentinin orta maaşından çox qazanan işçilər.
- `DENSE_RANK()` ilə departament daxilində maaş sıralaması.

## Necə işlətmək olar?

1. Oracle SQL Developer proqramını aç.
2. HR sxemi olan verilənlər bazasına qoşul.
3. `hr_data_analysis.sql` faylını aç.
4. Sorğuları bir-bir seçib işə sal və nəticələri yoxla.

Qeyd: HR sxemi sənin bazanda aktiv olmalıdır. Əgər cədvəllərə başqa istifadəçi adı ilə qoşulursansa, sorğulardakı `hr.` prefiksini uyğunlaşdır.

## Fayllar

```text
oracle-hr-data-analysis/
├── README.md
└── hr_data_analysis.sql
```
