# Use the latest Alpine Linux image as the base
FROM alpine:latest

# Set the working directory to /root
WORKDIR /root

# Install required packages
RUN apk update && \
    apk add git nodejs neovim neovim-doc ripgrep build-base wget curl

# Install Vim-Plug
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Clone the NvChad starter repository
RUN git clone https://github.com/NvChad/starter ~/.config/nvim

# Copy the custom init.vim and entrypoint script into the container
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint to the shell script
ENTRYPOINT ["entrypoint.sh"]
