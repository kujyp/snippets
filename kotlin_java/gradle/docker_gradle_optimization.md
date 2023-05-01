# docker_gradle_optimization
- 검색어: dockerfile java kotlin gradlew dependency optimization cache layer
- java dockerfile cache layer
```dockerfile
FROM openjdk:17-slim as build

WORKDIR /app

COPY gradlew .
COPY gradle gradle

# gradlew download optiomization
RUN ./gradlew

COPY settings.gradle.kts .
COPY build.gradle.kts .

# Dependency download optimization
RUN ./gradlew check
# or RUN ./gradlew build || true
# || true 는 ./gradlew build 가 src 폴더가 없으면 실패로 끝나는데,
# 거기서 docker build 가 끝나는것을 방지해줌.(./gradlew check 로 진행해도됨) 

COPY src src

RUN ./gradlew jar


FROM openjdk:17-slim

WORKDIR app

COPY --from=build /app/build/libs/*.jar .
EXPOSE 8080

CMD java -jar *.jar
```
