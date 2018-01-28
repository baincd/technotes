# Return checked out branch-name/tag-name/commit-id
git branch | sed -n 's/^\* //p' | sed 's/^(HEAD detached at \(.*\))/\1/'
# Returns:
#     branch-name
#     tag-name
#     a1b2c3d

# Return checked out branch-name/tag-name reference
git branch | grep "^* " | sed 's|^* (HEAD detached at \(.*\))|refs/tags/\1|' | sed 's|^* \(.*\)|refs/heads/\1|'
# Returns:
#      refs/heads/branch-name
#      refs/tags/tag-name
# *Note*: A detached HEAD pointing to a commit ID will incorrectly resolve to a refs/tags/a1b2c3d
