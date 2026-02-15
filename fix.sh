#!/bin/bash

set -e

echo "Fixing Android package structure..."

OLD_PACKAGE="com.example.reminiscence"
NEW_PACKAGE="com.robotbramhana.reminiscence"

OLD_PATH="app/src/main/java/com/example/reminiscence"
NEW_PATH="app/src/main/java/com/robotbramhana/reminiscence"

# Create new directory
mkdir -p app/src/main/java/com/robotbramhana

# Move folder
if [ -d "$OLD_PATH" ]; then
    mv "$OLD_PATH" "$NEW_PATH"
    echo "Moved folder to $NEW_PATH"
fi

# Remove old empty folders
rm -rf app/src/main/java/com/example || true

# Fix package name in Kotlin files
find app/src -type f -name "*.kt" -exec sed -i "s/$OLD_PACKAGE/$NEW_PACKAGE/g" {} +

echo "Fixed Kotlin package names"

# Fix Gradle namespace
GRADLE_FILE="app/build.gradle.kts"

if [ -f "$GRADLE_FILE" ]; then
    sed -i "s/namespace = \".*\"/namespace = \"$NEW_PACKAGE\"/g" "$GRADLE_FILE"
    sed -i "s/applicationId = \".*\"/applicationId = \"$NEW_PACKAGE\"/g" "$GRADLE_FILE"
    echo "Fixed gradle namespace"
fi

# Fix AndroidManifest
MANIFEST="app/src/main/AndroidManifest.xml"

if [ -f "$MANIFEST" ]; then
    sed -i "s/package=\".*\"/package=\"$NEW_PACKAGE\"/g" "$MANIFEST" || true
    echo "Fixed manifest"
fi

# Commit and push
git add .
git commit -m "Fix package name to robotbramhana"
git push

echo ""
echo "DONE."
echo "APK build will start automatically on GitHub Actions."

