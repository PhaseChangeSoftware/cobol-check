# ISSUES

## Gradle Fail to Build
```
Execution failed for task ':compileJava'.
> Java compilation initialization error
    error: invalid source release: 21
```
If this appears when building, the cause is that Gradle is using a java 11 JDK, and from this commit onward Java 21 is
necessary. The best way to do this (in IntelliJ) is to go to the Gradle window, click the build tool settings icon
(gear in top right), go to Gradle Settings and set the Gradle JVM to `temurin-21`.