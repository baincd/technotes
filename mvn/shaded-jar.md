```xml
  <build>
    <plugins>
      <plugin>
        <groupId>org.apache.maven.plugins</groupId>
        <artifactId>maven-shade-plugin</artifactId>
        <executions>
          <execution>
            <configuration>
              <!-- Minimize shaded jar - requires certain classes not explicitly references to be included, like logback -->
              <minimizeJar>true</minimizeJar>
              <filters>
                <filter>
                  <artifact>ch.qos.logback:logback-classic</artifact>
                  <includes>
                    <include>**/*</include>
                  </includes>
                </filter>
              </filters>
            </configuration>
          </execution>
        </executions>
      </plugin>
    </plugins>
  </build>

```
