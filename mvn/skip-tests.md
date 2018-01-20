## This should only be used for emergencies temporarily!

```
-DskipTests

-Dmaven.test.skip=true

<properties>
    <skipTests>true</skipTests>
</properties>

<plugin>
    <artifactId>maven-surefire-plugin</artifactId>
    <configuration>
        <skipTests>true</skipTests>
    </configuration>
</plugin>
```
