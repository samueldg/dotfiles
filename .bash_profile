# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";


for file in ~/.{path,exports,aliases,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

shopt -s histappend;

cd workspace/
