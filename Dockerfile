FROM swipl:stable

WORKDIR /app

COPY prolog/ ./prolog/

EXPOSE 8080

CMD ["swipl", "prolog/server.pl"]