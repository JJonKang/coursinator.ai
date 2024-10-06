FROM python:3.11

WORKDIR /scraper

# Copy only the necessary files into the Docker image
COPY ../src/scrape/ .

RUN pip install requests beautifulsoup4

EXPOSE 1425

CMD ["tail", "-f", "/dev/null"]
