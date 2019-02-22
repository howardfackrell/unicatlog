FROM quay.octanner.io/base/oct-scala:2.12.4-sbt-0.13.16-play-2.6.9 as builder
COPY . .
RUN sbt clean stage

FROM quay.octanner.io/base/oct-openjdk:8
RUN mkdir -p target/universal/stage
COPY --from=builder /app/target/universal/stage ./target/universal/stage
COPY ./start.sh .
EXPOSE 9000
CMD [ "./start.sh" ]
