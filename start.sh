docker build -t fzf-loongarch64 .
docker run --rm -v "$(pwd)"/dist:/dist fzf-loongarch64
ls -al "$(pwd)"/dist
