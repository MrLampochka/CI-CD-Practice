# Сгенерировать рабочий requirements.txt из зависимостей Poetry
FROM python:3.12-slim AS requirements

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    gcc \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

RUN python -m pip install --no-cache-dir --upgrade poetry
RUN python -m pip install --no-cache-dir poetry-plugin-export

COPY pyproject.toml poetry.lock ./
RUN poetry export -f requirements.txt --without-hashes -o requirements.txt


# Финальный образ приложения
FROM python:3.12-slim AS app

# Переключение на непривилегированного пользователя appuser
RUN adduser --disabled-password --gecos "" appuser
WORKDIR /app

# Установка requirements
COPY --from=requirements /requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Копируем код
COPY --chown=appuser:appuser . .
USER appuser:appuser
CMD ["python", "main.py"]