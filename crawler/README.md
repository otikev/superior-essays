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
sudo docker build -t secrawler:latest .
```
Set agent token in SE_AGENT_TOKEN environment variable

Run image
```
sudo docker run --env SE_AGENT_TOKEN=$SE_AGENT_TOKEN secrawler
```

Run image in background and print container ID
```
sudo docker run -d --env SE_AGENT_TOKEN=$SE_AGENT_TOKEN secrawler
```

See running images
```
sudo docker ps
```