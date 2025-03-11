function combine_images
    if not type -q magick
        echo "❌ ImageMagick 'magick' command not found!"
        return 1
    end

    if not type -q identify
        echo "❌ ImageMagick 'identify' command not found!"
        return 1
    end

    if test (count $argv) -ne 3
        echo "Usage: combine_images image1.png image2.png output.png"
        return 1
    end

    set img1 $argv[1]
    set img2 $argv[2]
    set out $argv[3]

    # Check if files exist
    if not test -f $img1
        echo "❌ File not found: $img1"
        return 1
    end

    if not test -f $img2
        echo "❌ File not found: $img2"
        return 1
    end

    # Get image heights
    set h1 (identify -format "%h" $img1)
    set h2 (identify -format "%h" $img2)

    # Determine tallest
    if test $h1 -ge $h2
        set max_height $h1
    else
        set max_height $h2
    end

    echo "📏 Resizing images to height: $max_height px"

    # Combine images
    magick \
        \( $img1 -resize x$max_height \) \
        \( $img2 -resize x$max_height \) \
        +append $out

    echo "✅ Combined image saved as: $out"
end