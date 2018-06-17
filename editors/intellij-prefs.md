# My IntelliJ IDEA Preferences

## Use tabs for indenting
Settings->Editor->Code Style->Java->Tabs and Indents->Use tab character, Smart tabs

## Set JUnit static imports
Settings->Editor->File and Code Templates->Code->JUnit4 Test class \
replace `org.junit.Assert.*` import with:
```java
import static org.hamcrest.Matchers.is;
import static org.junit.Assert.assertThat;
import static org.mockito.Matchers.any;
import static org.mockito.Mockito.mock;
```

## Font Size

Settings->Editor->General->Change font size (zoom) with Ctrl+Mouse Wheel
