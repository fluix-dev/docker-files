FROM python:buster
ENV PYTHONBUFFERED 1

RUN apt update && apt install -y git
RUN git clone https://github.com/TheAvidDev/site.git
WORKDIR /site
RUN pip install django
RUN pip install pillow
RUN pip install django-admin-sortable2
RUN pip install git+https://github.com/TheAvidDev/django-discord-integration.git#egg=django-discord-integration
RUN pip install gunicorn
RUN pip install psycopg2
COPY local_settings.py /site/mysite

EXPOSE 8000

CMD ["gunicorn","--bind","0.0.0.0:8000","--workers","3","--env","DJANGO_SETTINGS_MODULE=mysite.local_settings","mysite.wsgi:application"]
