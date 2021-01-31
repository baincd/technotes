```java
import static org.assertj.core.api.Assertions.assertThat;

import java.util.function.Consumer;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.slf4j.LoggerFactory;

import ch.qos.logback.classic.Level;
import ch.qos.logback.classic.Logger;
import ch.qos.logback.classic.spi.ILoggingEvent;
import ch.qos.logback.core.read.ListAppender;

public class LoggingTest {

	private Example classUnderTest = new Example();

	private ListAppender<ILoggingEvent> logAppender;
	private Logger logger = (Logger) LoggerFactory.getLogger(Example.class);

	@BeforeEach
	public void setUp() {
		logAppender = new ListAppender<>();
		logAppender.start();
		logger.addAppender(logAppender);
	}

	@AfterEach
	public void tearDown() {
		logger.detachAppender(logAppender);
	}

	@Test
	public void testSayHi() {
		classUnderTest.sayHi("Java");

		assertThat(logAppender.list).anySatisfy(logEventRegex(Level.INFO, "Hello Java!"));
	}

	private Consumer<? super ILoggingEvent> logEventRegex(Level level, String regex) {
		return e -> {
			assertThat(e.getFormattedMessage()).matches(regex);
			assertThat(e.getLevel()).isEqualTo(level);
		};
	}

}
```

Ref: https://mincong.io/2020/02/02/logback-test-logging-event/#test
