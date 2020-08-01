# Setup spring boot devtools properties for local development

`~/.config/spring-boot/spring-boot-devtools.properties`

```properties
# Use ANSI colors in output
spring.output.ansi.enabled=always

# Default Spring Boot Logging Pattern: https://github.com/spring-projects/spring-boot/blob/master/spring-boot-project/spring-boot/src/main/resources/org/springframework/boot/logging/logback/defaults.xml

logging.pattern.console=%clr(%d{yyyy-MM-dd HH:mm:ss.SSS}){faint} %clr(%5p) %clr(---){faint} %clr([%15.15t]){faint} %clr(%-40.40logger{39}){cyan} %clr(:){faint} %m%n%wEx
logging.pattern.file=%d{yyyy-MM-dd HH:mm:ss.SSS} %5p --- [%t] %-40.40logger{39} : %m%n%wEx

logging.level.root=info
logging.level.org.springframework=info
logging.level.com.mycompany.myapp=debug

```
