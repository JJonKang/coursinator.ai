FROM python:3.11

WORKDIR /scrape

COPY . .

RUN pip install requests beautifulsoup4

EXPOSE 1425

CMD ["python", "scrape.py"]