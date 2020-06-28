`src/test/resources/application-test.properties`:
```properties
spring.main.banner-mode=off
```

`src/test/resources/logback-test.xml`:
```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <include resource="org/springframework/boot/logging/logback/base.xml" />
    <logger name="root" level="ERROR"/>
</configuration>
```
