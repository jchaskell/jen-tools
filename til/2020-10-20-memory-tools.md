Today I learned (or am writing down) tools for investigating memory issues.

To see the full size (including content) of all files and folders within
a directory:
``ls | xargs -I fileorfolder du -hs fileorfolder | sort -h``
`
