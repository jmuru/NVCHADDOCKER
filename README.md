### Build

docker build -t my-neovim-env .


### Run

docker run -it --rm -v $(pwd):/workspace my-neovim-env /workspace
