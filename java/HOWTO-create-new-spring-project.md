1. git init
2. Create new Spring project:
  https://start.spring.io/#!type=maven-project&language=java&packaging=jar&dependencies=lombok,devtools,web,actuator
3. Create .gitignore:
  1. https://www.gitignore.io/?templates=java,maven,eclipse,intellij
  2. Add <!-- See https://github.com/toptal/gitignore/pull/275 -->

    ```
    # Eclipse Core
    .project

    # JDT-specific (Eclipse Java Development Tools)
    .classpath
    ```

4. Create .gitattributes

```properties
# Eclipse defaults to core.autocrlf=false which causes issues on Windows
# See https://netmikey.wordpress.com/2016/06/01/eclipse-git-mind-your-windows-line-endings/

# The following configuration will effectively enable autocrlf to true
# for the repo (even from Eclipse) and prevent those annoying line ending issues

# Handle line endings automatically for files detected as text
# and leave all files detected as binary untouched.
* text=auto
```

5. Create lombok.config
```
# https://projectlombok.org/features/configuration

# Tell lombok this is your root directory, and stop lombok from looking at
# parent directories for more configuration files
config.stopBubbling = true

# Do not count Lombok generated code against code coverage
#   https://stackoverflow.com/a/44584898
lombok.addLombokGeneratedAnnotation = true

# Copy Spring annotations from the field to the constructor parameter,
# the setter parameter, and the getter method
#   https://projectlombok.org/features/constructor
lombok.copyableAnnotations += org.springframework.beans.factory.annotation.Autowired
lombok.copyableAnnotations += org.springframework.beans.factory.annotation.Qualifier
lombok.copyableAnnotations += org.springframework.beans.factory.annotation.Value
```

6. Add commons-lang3 dependency

```xml
		<dependency>
			<groupId>org.apache.commons</groupId>
			<artifactId>commons-lang3</artifactId>
		</dependency>
```

7. Add Health status on application startup
```java
import org.springframework.beans.BeansException;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.actuate.health.HealthEndpoint;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;

import lombok.extern.slf4j.Slf4j;

@SpringBootApplication
@Slf4j
public class DemoApplication {

	public static void main(String[] args) {
		ConfigurableApplicationContext ctx = SpringApplication.run(DemoApplication.class, args);

		try {
			HealthEndpoint healthEndpoint = ctx.getBean(HealthEndpoint.class);

			log.info("Application Started with health status of {}",healthEndpoint.health().getStatus());

		} catch (BeansException | NoClassDefFoundError e) {
			log.info("Application Started (health status unavailable)");			
		}

	}

}
```
