function find_and_replace($find, $replace) {
    (dir *.md -Recurse).FullName | ForEach-Object {
        (Get-Content -Path $_ -Raw) -replace "$find", "$replace" |
            Set-Content -Path $_ -NoNewline }
}

find_and_replace("wp-content/uploads", "dvlup-blog/wp-content/uploads")