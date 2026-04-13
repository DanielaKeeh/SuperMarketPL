FROM swipl:stable

WORKDIR /app

COPY minisuper_server.pl .

EXPOSE 8080

CMD ["swipl", "minisuper_server.pl"]