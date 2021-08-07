# Preferred Java/Spring extension settings

settings.json:
```jsonc
    //   "java.configuration.runtimes": [ # JDKs available to build/run code
    //     {
    //       "name": "JavaSE-1.8",
    //       "path": "c:\\path\\to\\jdk"
    //     }
    //   ],
    //   "java.home": "c:\\path\\to\\jdk", # JDK used by Java Language Server
    //   "spring-boot.ls.java.home": "c:\\path\\to\\jdk" # JDK used by Spring Boot Language Server
    "java.import.gradle.enabled": false,
    "java.maven.downloadSources": true,
    "java.test.report.showAfterExecution": "always",
    "java.completion.favoriteStaticMembers": [
        "java.text.MessageFormat.*", // Added
        
        "org.assertj.core.api.Assertions.*", // Added
        "org.hamcrest.Matchers.*", // Added
        "org.junit.Assert.*",
        "org.junit.Assume.*",
        "org.junit.jupiter.api.Assertions.*",
        "org.junit.jupiter.api.Assumptions.*",
        "org.junit.jupiter.api.DynamicContainer.*",
        "org.junit.jupiter.api.DynamicTest.*",
        "org.mockito.Mockito.*",
        "org.mockito.ArgumentMatchers.*",
        "org.mockito.Answers.*"
    ],
    "java.debug.settings.stepping.skipClasses": [
        "$JDK", // Added
        "$Libraries", // Added
        "java.lang.ClassLoader" // Added
    ],
    "java.referencesCodeLens.enabled": false, // Enable by default, may be changed by Settings-on-fire
    "java.autobuild.enabled": true, // no change from default, may be changed by Settings-on-fire
```

# Maven dependency tree commands

settings.json:
```json
    "maven.terminal.favorites": [
        { "alias": "gen build dependency tree", "command": "dependency:tree -Dverbose -DoutputFile=maven-build-dependencies io.github.floverfelt:find-and-replace-maven-plugin:1.0:find-and-replace \"-DfindRegex=(\\\\+-|\\| |\\\\\\-)\" \"-DreplaceValue=  \" -DreplacementType=file-contents -DfileMask=maven-build-dependencies" },
        { "alias": "gen plugin dependency tree", "command": "dependency:resolve-plugins -Dverbose -DoutputFile=maven-plugin-dependencies" }
    ],
```

# Java: Create Test Class shortcut

Extension required: Java Tests `wesleyegberto.vscode-java-tests`

keybindings.json:
```jsonc
    {
        "key": "ctrl+; t",
        "command": "java.tests.createTestClass",
        "when": "resourceFilename =~ /(?<!Test)\\.java/"
    },
```
