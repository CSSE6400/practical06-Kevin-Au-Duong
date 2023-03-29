#!/bin/bash
#
# Ensure that students have not committed inappropriate files for a Git repository.

# The following files are not allowed in a Git repository.
ILLEGAL_FILES=(.DS_Store .localized .DS_Store? ._* .Spotlight-V100 .Trashes Thumbs.db ehthumbs.db desktop.ini)
ILLEGAL_FILES+=(*.pyc *.pyo *.exe *.dll *.so *.a *.o *.obj *.lib)
ILLEGAL_FILES+=(__pycache__ *.class *.jar *.war *.rar)
ILLEGAL_FILES+=(*.sqlite *.sqlite3 *.sqlite-journal *.db *.db-journal)
ILLEGAL_FILES+=(credentials .terraform)

failed=0
for file in "${ILLEGAL_FILES[@]}"; do
    matches=$(git ls-files "${file}" 2>/dev/null)
    if [[ -n "${matches}" ]]; then
        echo "Found illegal file: ${matches}"
        failed=1
    fi
done

if [ $failed -eq 1 ]; then
    echo "FAIL: Found illegal files in repository."
    echo "These files should not be committed to Git repositories - it is a good practice to add them to a .gitignore file."
    echo "Please remove these files and try again."
    exit 1
fi

