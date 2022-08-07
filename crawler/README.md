# SECrawler

Execute the jar task to generate a jar file.
```aidl
./gradlew jar
```
Execute the jar file from this project directory
```aidl
java $JAVA_OPTS -jar build/libs/SECrawler-1.0-SNAPSHOT.jar
```

## Docker

Build
```
docker build -t secrawler:latest .
```

Run
```
sudo docker run --env SE_AGENT_TOKEN={value} secrawler
```