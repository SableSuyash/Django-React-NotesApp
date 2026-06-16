FROM python:3.8-slim AS build

WORKDIR /app

COPY requirements.txt .
RUN apt-get update
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

RUN python manage.py makemigrations
RUN python manage.py migrate

FROM python:3.8-slim
WORKDIR /app

COPY --from=build . /app

EXPOSE 8000

CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
