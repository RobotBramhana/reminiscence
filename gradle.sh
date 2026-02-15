#!/bin/bash

echo "Installing proper Gradle wrapper..."

mkdir -p gradle/wrapper

# download Gradle 8.7 distribution
wget -q https://services.gradle.org/distributions/gradle-8.7-bin.zip -O gradle-8.7-bin.zip

# extract wrapper jar
unzip -q gradle-8.7-bin.zip gradle-8.7/lib/plugins/gradle-wrapper-8.7.jar

# move and rename
cp gradle-8.7/lib/plugins/gradle-wrapper-8.7.jar gradle/wrapper/gradle-wrapper.jar

# cleanup
rm -rf gradle-8.7 gradle-8.7-bin.zip

# create wrapper properties
cat <<EOF > gradle/wrapper/gradle-wrapper.properties
distributionBase=GRADLE_USER_HOME
distributionPath=wrapper/dists
distributionUrl=https\\://services.gradle.org/distributions/gradle-8.7-bin.zip
zipStoreBase=GRADLE_USER_HOME
zipStorePath=wrapper/dists
EOF

# create gradlew script
cat <<'EOF' > gradlew
#!/usr/bin/env sh
DIR="$(cd "$(dirname "$0")"; pwd)"
exec java -classpath "$DIR/gradle/wrapper/gradle-wrapper.jar" org.gradle.wrapper.GradleWrapperMain "$@"
EOF

chmod +x gradlew

echo "Wrapper installed successfully"

