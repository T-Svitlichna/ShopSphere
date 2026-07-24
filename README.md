# ShopSphere — Geschäftsanalyse 2022–2024

> Analyseprojekt: Datenqualitätsprüfung → SQL → Visualisierung → Dashboard → Business Cases → statistisches Denken (A/B-Test).

**Autorin:** Svitilichna Tetiana

🔗 **Präsentations-Website (live):** [ShopSphere Presentation](https://t-svitlichna.github.io/ShopSphere/)
🔗 **Dashboard (Tableau Public):** [ShopSphere Dashboard](https://public.tableau.com/views/Abschlussproect/Dashboard1?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

---

## Inhaltsverzeichnis

1. [Über das Projekt](#über-das-projekt)
2. [Daten](#daten)
3. [Technologien](#technologien)
4. [Projektstruktur](#projektstruktur)
5. [Vorgehensweise](#vorgehensweise)
6. [Fazit für den CEO](#fazit-für-den-ceo)

---

## Über das Projekt

ShopSphere ist ein globaler Online-Marktplatz, der Produkte aus 7 Kategorien in 5 Regionen weltweit verkauft. Dieses Projekt durchläuft den vollständigen Analysezyklus: von den Rohdaten in 5 Tabellen bis zum Dashboard für den Vorstand und strategischen Empfehlungen für den CEO.

Der CEO hat fünf Fragen gestellt:

- Wohin fließt das Marketingbudget, und ist es effizient?
- Wer sind unsere wertvollsten Kunden?
- Welche Kategorien sind wirklich profitabel, und welche erzeugen nur eine Volumen-Illusion?
- Welche Regionen sind unsere Zukunft?
- Hat das Checkout-Experiment funktioniert oder nicht?

Dieses Repository liefert eine strukturierte, datenbasierte Antwort auf alle fünf Fragen.

---

## Daten

Verwendet wurden 5 verknüpfte Tabellen (2022–2024):

| Tabelle | Beschreibung | Umfang |
|---|---|---|
| `shopsphere_customers` | Kunden: Region, Land, Alter, Geschlecht, Akquisitionskanal | ~3.000 |
| `shopsphere_products` | Produkte: Kategorie, Preis, Kosten, Marge | 250 |
| `shopsphere_orders` | Bestellungen: Datum, Kanal, Rabatt, Beträge, A/B-Variante | ~12.300 (11.075 einfülltr) |
| `shopsphere_order_items` | Bestellpositionen | ~26.000 |
| `shopsphere_marketing` | Marketingkampagnen nach Kanal und Monat | 216 |

📄 Rohdaten: Ordner [`data/`](./data)

---

## Technologien

- **SQL** (SQLite / sqliteonline.com) — Datenaufbereitung und Aggregation
- **Tableau Public** — Visualisierungen und interaktives Dashboard
- **HTML/CSS/JS** — zweisprachiges (UA/DE) Präsentations-Landingpage

---

## Projektstruktur

```
├── README.md
├── README_ukr.md                    # diese Datei
├── data/                            # Roh-CSV-Tabellen
├── SQL_abfragen/                    # SQL-Abfragen
├── Tableau/                         # File - Tableau Public

```

---

## Vorgehensweise

### 0. Datenqualitätsprüfung

Vor jeder Berechnung wurde die interne Konsistenz der Tabellen geprüft — sind die Zahlen überhaupt vertrauenswürdig?

**Drei Hypothesen geprüft:**

1. **`net_amount` = `gross_amount` − `discount_amount`?**
   Abweichung in **3.269 von ~11.000 Bestellungen** (~30%) gefunden. Als Grundlage für alle weiteren Berechnungen wurde das Feld **`net_amount`** verwendet — der tatsächlich vom Kunden gezahlte Betrag.
2. **`line_total` = `quantity × unit_price`?**
   ✅ Keine Abweichung gefunden — Berechnung korrekt.
3. **`discount_amount` = `gross_amount × discount_pct / 100`?**
   Abweichung in **263 von ~11.000 Bestellungen** (~2,4%) — als unwesentlich eingestuft.

📄 Vollständiger Prüfcode: [`Перевірка_баз_данних.docx`](./Перевірка_баз_данних.docx)

### 1. SQL: Datenaufbereitung

Fünf Abfragen (JOINs, Aggregationen, Unterabfragen), die die Grundlage für Visualisierung und Business Cases bilden:

1. Umsatz nach Jahr und Region
2. Top-10-Kunden nach Umsatz
3. Umsatz, Marge und Retouren nach Kategorie
4. Kunden mit überdurchschnittlichen Ausgaben (Unterabfrage) — Grundlage für die Top-5%-Berechnung
5. ROI und Effizienz der Marketingkanäle

📄 Abfragen: Ordner [`sql_abfragen/`](./sql_abfragen)

### 2. Dashboard

Ein interaktives Dashboard, aufgebaut als Geschichte von oben nach unten:

1. **KPI-Karten** — Umsatz, Bestellungen, durchschnittlicher Bestellwert, Retourenquote
2. **Dynamik** — Umsatzwachstum pro Quartal, Wachstum der Regions-Effizienz
3. **Produktivität** — Umsatz/Marge/Retouren nach Kategorie
4. **Marketing** — Budget gegen Gewinn pro Dollar

🔗 [Dashboard auf Tableau Public ansehen](https://public.tableau.com/views/Abschlussproect/Dashboard1?:language=en-US&publish=yes&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)

### 3. Fall „Budget": Marketingbudget und ROI nach Kanal

Paid Search erhält das größte Budget (451 Tsd. $), liefert aber den niedrigsten ROI (+32,7%). Organic hat den besten ROI (+701%), ist jedoch unterfinanziert. Der Kampagnen-ROI wurde mit dem langfristigen Kundenwert (LTV) verglichen — die Schlussfolgerungen stimmen nicht immer überein. Eine Empfehlung zur Budgetumverteilung inklusive Risikoabschätzung wurde erarbeitet.

### 4. Fall „Kategorien": Umsatz ≠ Gewinn

Electronics ist eine „Volumen-Illusion" (57% Umsatz, 12% Marge, 16% Retouren). Beauty ist der „verborgene Diamant" (55% Marge bei nur 4,6% Umsatzanteil). Zusätzlich wurde untersucht, welche Regionen am schnellsten wachsen (Southeast Asia, Middle East) und welche stagnieren (Europe, North America).

### 5. Fall „Kunden": Rabatte und wertvolle Kunden

Rabatte über 20% bauen keine Loyalität auf: Kunden mit Rabatt tätigen nur halb so viele Bestellungen (2 statt 4). Die Top-5%-Kunden erwirtschaften 35% des Umsatzes — vor allem über Influencer in Europe. Empfehlung: ein VIP-Programm statt Massenrabatte.

### 6. A/B-Test: Checkout

Ein klassisches Beispiel für das Simpson-Paradoxon: Der Gesamteffekt von Variante B (+2%) verbirgt, dass er neuen Kunden stark hilft (+13,1%), Bestandskunden hingegen kaum (+1,2%). Es wurde untersucht, wie das Marketing diese Zahlen manipulieren könnte, und wie ein ehrlicher Analyst sie präsentiert.

---

## Fazit für den CEO

Fünf konkrete Antworten auf die Fragen aus der Projektlegende:

| Frage des CEO | Antwort |
|---|---|
| Wohin fließt das Marketingbudget, und ist es effizient? | Nicht immer — Paid Search ist ineffizient, Organic unterfinanziert |
| Wer sind unsere wertvollsten Kunden? | Die Top-5% erwirtschaften 35% des Umsatzes, Rabatte binden sie nicht |
| Welche Kategorien sind wirklich profitabel? | Electronics ist eine Volumen-Illusion, Beauty der echte Gewinnbringer |
| Welche Regionen sind unsere Zukunft? | Southeast Asia und Middle East, nicht Europe oder North America |
| Hat der A/B-Test funktioniert? | Ja, für neue Kunden — bei Bestandskunden ist es für ein Fazit noch zu früh |

Ausführlich in der [Projektpräsentation](https://drive.google.com/file/d/1oggIIGP9saXxdrap-Oc7cpSRLBWI-PtR/view?usp=sharing).

