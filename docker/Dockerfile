FROM python:3.6

WORKDIR /src/app

COPY requirements.txt ./

RUN pip install -r requirements.txt

EXPOSE 8000
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]