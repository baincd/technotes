## Remove Spring from pom.xml
1. Remove `<parent>` tag
2. Add properties
```xml
	<properties>
		<java.version>1.8</java.version>
		<project.build.sourceEncoding>UTF-8</project.build.sourceEncoding>
	</properties>
```
3. Set dependency management versions
```xml
	<dependencyManagement>
		<dependencies>
			<dependency>
				<groupId>org.springframework.boot</groupId>
				<artifactId>spring-boot-dependencies</artifactId>
				<version>2.1.6.RELEASE</version>
				<type>pom</type>
				<scope>import</scope>
				<!-- https://github.com/spring-projects/spring-boot/blob/v2.1.6.RELEASE/spring-boot-project/spring-boot-dependencies/pom.xml -->
			</dependency>
		</dependencies>
	</dependencyManagement>
```
4. Add production code dependencies
```xml
	 <dependency>
			<groupId>org.slf4j</groupId>
			<artifactId>slf4j-api</artifactId>
	 </dependency>
		<dependency>
			<groupId>ch.qos.logback</groupId>
			<artifactId>logback-classic</artifactId>
		</dependency>
```
5. Add test dependencies
```xml
		<dependency>
			<groupId>junit</groupId>
			<artifactId>junit</artifactId>
			<scope>test</scope>
		<dependency>
		</dependency>
			<groupId>org.assertj</groupId>
			<artifactId>assertj-core</artifactId>
			<scope>test</scope>
		</dependency>
		<dependency>
			<groupId>org.mockito</groupId>
			<artifactId>mockito-core</artifactId>
			<scope>test</scope>
		</dependency>
		<dependency>
			<groupId>org.hamcrest</groupId>
			<artifactId>hamcrest-library</artifactId>
			<scope>test</scope>
		</dependency>
		<dependency>
			<groupId>org.skyscreamer</groupId>
			<artifactId>jsonassert</artifactId>
			<scope>test</scope>
		</dependency>
```
