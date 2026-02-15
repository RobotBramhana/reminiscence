#!/bin/bash
set -e

OLD_PACKAGE="com.sudhanva.reminiscence"
NEW_PACKAGE="com.robotbramhana.reminiscence"

echo "Fixing package mismatch (GitHub-only mode)..."

# Create correct directory
mkdir -p app/src/main/java/com/robotbramhana/reminiscence

# Copy files if old exists
if [ -d "app/src/main/java/com/sudhanva/reminiscence" ]; then
    cp -r app/src/main/java/com/sudhanva/reminiscence/* \
          app/src/main/java/com/robotbramhana/reminiscence/
fi

# Remove old folder
rm -rf app/src/main/java/com/sudhanva || true

# Fix package declarations in Kotlin files
find app -name "*.kt" -exec sed -i "s/$OLD_PACKAGE/$NEW_PACKAGE/g" {} +

# Fix Gradle config
sed -i "s/namespace = \".*\"/namespace = \"$NEW_PACKAGE\"/g" app/build.gradle.kts
sed -i "s/applicationId = \".*\"/applicationId = \"$NEW_PACKAGE\"/g" app/build.gradle.kts

# Fix manifest
sed -i "s/package=\".*\"/package=\"$NEW_PACKAGE\"/g" \
app/src/main/AndroidManifest.xml 2>/dev/null || true

# Commit and push
git add .
git commit -m "Fix package name to robotbramhana"
git push

echo ""
echo "DONE. GitHub will now build the APK automatically."

