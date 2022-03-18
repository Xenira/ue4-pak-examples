#!/bin/bash

. .env

rm -rf pak
rm -rf target

mkdir target
export REPO_PATH=$REPO_PATH
envsubst < build/test_contents.txt > target/test_contents.txt

pak() {
    "$PAK_PATH" $REPO_PATH/pak/v$VERSION/test_v$VERSION.pak -Create=\"$REPO_PATH\\target\\test_contents.txt\"
    "$PAK_PATH" $REPO_PATH/pak/v$VERSION/test_encrypted_v$VERSION.pak -Create=\"$REPO_PATH\\target\\test_contents.txt\" $CRYPTO_KEYS -Encrypt
    if $INCLUDE_ENCINDEX
    then
        "$PAK_PATH" $REPO_PATH/pak/v$VERSION/test_encrypted_encindex_v$VERSION.pak -Create=\"$REPO_PATH\\target\\test_contents.txt\" $CRYPTO_KEYS -Encrypt -encryptindex
        "$PAK_PATH" $REPO_PATH/pak/v$VERSION/test_encindex_v$VERSION.pak -Create=\"$REPO_PATH\\target\\test_contents.txt\" $CRYPTO_KEYS -encryptindex
    fi

    "$PAK_PATH" $REPO_PATH/pak/v$VERSION/test_compressed_v$VERSION.pak -Create=\"$REPO_PATH\\target\\test_contents.txt\" -compress
    "$PAK_PATH" $REPO_PATH/pak/v$VERSION/test_compressed_encrypted_v$VERSION.pak -Create=\"$REPO_PATH\\target\\test_contents.txt\" $CRYPTO_KEYS -Encrypt -compress

    if $INCLUDE_ENCINDEX
    then
        "$PAK_PATH" $REPO_PATH/pak/v$VERSION/test_compressed_encrypted_encindex_v$VERSION.pak -Create=\"$REPO_PATH\\target\\test_contents.txt\" $CRYPTO_KEYS -Encrypt -encryptindex -compress
        "$PAK_PATH" $REPO_PATH/pak/v$VERSION/test_compressed_encindex_v$VERSION.pak -Create=\"$REPO_PATH\\target\\test_contents.txt\" $CRYPTO_KEYS -encryptindex -compress
    fi
}

# Current crypto settings (aes-256)
CRYPTO_KEYS=-cryptokeys=\"$REPO_PATH\\build\\cryptoKeys.json\"
INCLUDE_ENCINDEX=true

# Version 11
PAK_PATH=$ENGINE_PATH$PAK_V11$UNREAL_PAK_PATH
VERSION=11
pak

# Version 9
PAK_PATH=$ENGINE_PATH$PAK_V9$UNREAL_PAK_PATH
VERSION=9
pak

# Version 8
PAK_PATH=$ENGINE_PATH$PAK_V8$UNREAL_PAK_PATH
VERSION=8
pak

# Version 7
PAK_PATH=$ENGINE_PATH$PAK_V7$UNREAL_PAK_PATH
VERSION=7
pak

# Version 5
PAK_PATH=$ENGINE_PATH$PAK_V5$UNREAL_PAK_PATH
VERSION=5
pak

# Legacy crypto (aes-128)
CRYPTO_KEYS=-aes=iiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii

# Version 4
PAK_PATH=$ENGINE_PATH$PAK_V4$UNREAL_PAK_PATH
VERSION=4
pak

# Lower versions dont support encrypted index
INCLUDE_ENCINDEX=false

# Version 3
PAK_PATH=$ENGINE_PATH$PAK_V3$UNREAL_PAK_PATH
VERSION=3
pak

# Version 2
PAK_PATH=$ENGINE_PATH$PAK_V2$UNREAL_PAK_PATH
VERSION=2
pak