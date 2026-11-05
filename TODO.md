# TODO — dalsze prace nad projektem

## Stan obecny

Aplikacja Django działa w Dockerze i lokalnym klastrze k3s w WSL2. Testy aplikacji przechodzą, a chart Helm, Terraform i README są przygotowane. Poniższe zadania nie są jeszcze zrobione.

## Pakiet dla kolegi: CI/CD

- [ ] Dodać workflow GitHub Actions uruchamiany przy Pull Requeście i pushu.
- [ ] W workflow uruchamiać testy Django oraz lint.
- [ ] Budować obraz aplikacji i publikować go do GitHub Container Registry (GHCR); tagować obraz numerem wersji lub skrótem commita.
- [ ] Nie przechowywać sekretów w repozytorium. Użyć GitHub Actions Secrets i dodać krótką instrukcję konfiguracji.
- [ ] Ustalić sposób wdrożenia na k3s. Klaster jest obecnie w lokalnym WSL2 i nie jest osiągalny z runnera GitHub-hosted; najprościej użyć self-hosted runnera w środowisku mającym dostęp do klastra.
- [ ] Po publikacji obrazu wdrożyć go przez Helm i sprawdzić wynik rollout’u.

**Kryterium ukończenia:** Pull Request uruchamia zielone testy i lint; push publikuje obraz do GHCR; wdrożenie wskazuje obraz z rejestru, a nie lokalny `docker-web:latest`.

## Wspólnie: OpenTelemetry i monitoring

- [ ] Dodać do aplikacji OpenTelemetry, eksport logów i metryk przez OTLP oraz co najmniej jedną własną metrykę biznesową, np. liczbę oddanych głosów.
- [ ] Uruchomić OTel Collector oraz Prometheusa i Grafanę; ustalić odbiornik dla logów, np. Loki.
- [ ] Przygotować dashboard Grafany pokazujący stan aplikacji i własną metrykę.
- [ ] Dodać i sprawdzić co najmniej jeden alert, np. brak dostępnych replik aplikacji.

**Kryterium ukończenia:** metryka i logi z aplikacji są widoczne w narzędziach, dashboard działa, a przykładowy alert można wywołać i potwierdzić.

## Wspólnie: niezawodność wdrożenia

- [ ] Rozwiązać wyścig startowy migracji i PostgreSQL. Po zimnym starcie WSL migracje próbowały połączyć się z bazą przed jej gotowością; aplikacja odzyskała sprawność po ponowieniach.
- [ ] Uruchamiać migracje jako pojedynczy Job przed aplikacją, zamiast osobnego initContainera w każdej replice.
- [ ] Potwierdzić, czy klaster w WSL2 jest akceptowany na zaliczenie. Jeśli prowadzący wymaga osobnej VM Ubuntu, przenieść k3s do takiej maszyny.

## Wspólnie: dokumentacja i prezentacja

- [ ] Uzupełnić README po wdrożeniu CI/CD i monitoringu; zachować limit 3 stron A4 i prosty opis dla osoby nietechnicznej.
- [ ] Przygotować krótką demonstrację: push kodu, wynik pipeline’u, działająca aplikacja, metryka, log i alert.
- [ ] Podzielić pracę tak, by obie osoby umiały wyjaśnić swoje elementy i znały działanie całego rozwiązania.
