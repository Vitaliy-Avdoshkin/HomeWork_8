FROM python:3.12-slim

WORKDIR /app

RUN apt-get update \\
  && apt-get install -y gcc libpg-dev \\
  && apt-get clean \\
  && rm -rf /var/lib/apt/lists/\*

COPY pyproject.toml poetry.lock .

RUN pip install poetry && \
    poetry config virtualenvs.create false && \
    poetry install --no-root



COPY . .

RUN mkdir -p /app/staticfiles && chmod -R 755 /app/staticfiles
# Открываем порт 8000 для взаимодействия с приложением
EXPOSE 8000

CMD ["sh", "-c", "python manage.py collectstatic --noinput && gunicorn config.wsgi:application --bind 0.0.0.0:8000"]
# Определяем команду для запуска приложения
# CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]