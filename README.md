### Requirements 

- install docker desktop
- brew install docker

### Build

docker build -t my-neovim-env .


### Run

docker run -it --rm -v $(pwd):/workspace my-neovim-env /workspace
