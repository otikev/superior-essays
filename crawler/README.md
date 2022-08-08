# SECrawler

Execute the jar task to generate a jar file.
```
./gradlew jar
```
Execute the jar file from this project directory
```
java $JAVA_OPTS -jar build/libs/SECrawler-1.0-SNAPSHOT.jar
```

## Docker

Build
```
docker build -t secrawler:latest .
```

Run assuming you have saved the token in SE_AGENT_TOKEN environment variable
```
sudo docker run --env SE_AGENT_TOKEN=$SE_AGENT_TOKEN secrawler
```