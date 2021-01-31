# 1) Create Files of Dependency Trees
```bash
# maxdepth 2 - only execute on immediate subdirs
find -maxdepth 2 -name pom.xml -execdir ./mvnw clean dependency:tree -DoutputFile=mvn-deps \;
```

# 2) Search Dependency trees
```bash
# Find projects using commons-lang3
grep --include mvn-deps "commons-lang3" -r *

# Find all uniq deps named commons-langg
grep --include mvn-deps -E " [^ ]*:commons-lang3:.*" -r -o -h | sort | uniq
```

# 3) Cleanup Dependency trees
```bash
find -name mvn-deps -exec rm {} \;
```
