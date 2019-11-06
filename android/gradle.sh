#!/usr/bin/env bash

# Gradle Dependencies Viewer http://gradle.vity.cz/
./gradlew :app:dependencies --configuration debugCompileClasspath > dep.txt
