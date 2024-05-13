# Use the latest Alpine Linux image as the base
FROM alpine:latest

# Set the working directory to /root
WORKDIR /root

# Install required packages, including Golang
RUN apk update && \
    apk add git nodejs neovim neovim-doc ripgrep build-base wget curl go

# Set GOPATH environment variable and add GOPATH/bin to PATH
ENV GOPATH=/root/go
ENV PATH=$GOPATH/bin:$PATH

# Install Vim-Plug
RUN curl -fLo /root/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Copy the local config-management directory to the Neovim config directory within /root
COPY config-management/nvchad-config /root/.config/nvim

# Create a .vimrc file and add the Go format autocommand
RUN echo 'lua <<EOF\n\
local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})\n\
vim.api.nvim_create_autocmd("BufWritePre", {\n\
  pattern = "*.go",\n\
  callback = function()\n\
   require("go.format").goimports()\n\
  end,\n\
  group = format_sync_grp,\n\
})\n\
EOF' > /root/.vimrc

# Copy the custom init.vim and entrypoint script into the container
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint to the shell script
ENTRYPOINT ["entrypoint.sh"]
