
extract_libs() {
    echo "Extraindo dependencias de: $1"
    ldd $1 | while read -r file; do
        IFS=' ' read -r -a array <<< "$file"
        
        if [ ${#array[@]} == 4 ]; then
            cp "${array[2]}" "$2/${array[0]}"
        fi
    done
}

extract_libs "lib/libSDL2.so" "lib"
extract_libs "lib/libSDL2_image.so" "lib"
extract_libs "lib/libSDL2_mixer.so" "lib"
extract_libs "lib/libSDL2_ttf.so" "lib"